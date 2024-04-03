//
//  Repository.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import Foundation

import Network
import Combine

protocol NetworkRepositoryProtocol {
    init(
        clientUDP: any ClientUDPProtocol,
        client: any ClientRPCProtocol,
        clientMappeer: any ClientStateMapperProtocol
    )
    
    var statePublisher: PassthroughSubject<ConnectionState, Never> { get set }
    var chatMessagePublisher: PassthroughSubject<ChatMessage, Never> { get set }
    var movePublisher: PassthroughSubject<Move, Never> { get set }
    
    func connect()
    func sendMessage(_ message: ChatMessage)
    func sendMove(_ move: Move)
}

class NetworkRepository: NetworkRepositoryProtocol {
    private var client: any ClientRPCProtocol
    private var clientUPD: any ClientUDPProtocol
    
    private var serverIP: String? {
        didSet {
            if let address = serverIP {
                self.connectTCP(address)
            }
        }
    }
    
    private var clientMapper: any ClientStateMapperProtocol
    
    var statePublisher = PassthroughSubject<ConnectionState, Never>()
    var chatMessagePublisher = PassthroughSubject<ChatMessage, Never>()
    var movePublisher = PassthroughSubject<Move, Never>()
    private var cancellables = Set<AnyCancellable>()
        
    required init(
        clientUDP: any ClientUDPProtocol,
        client: any ClientRPCProtocol,
        clientMappeer: any ClientStateMapperProtocol)
    {
        self.clientUPD = clientUDP
        self.client = client
        self.clientMapper = clientMappeer
        
        setSubscriptions()
    }
    
    func sendMove(_ move: Move) {
        do {
            let procedure = Procedure(procedure: .move, parameter: move)
            let data = try procedure.encodeToJson()
            client.callProcedure(data)
                .sink { _ in
                } receiveValue: { data in
                    do {
                        let procedure = try Procedure<Move>.decodeFromJson(data: data)
                        print(procedure)
                    } catch {
                        print(error)
                    }
                }
                .store(in: &cancellables)
        } catch {
            print(error)
        }
    }
    
    func connect() {
        clientUPD.discoverServer(port: CommunicationPorts.broker.rawValue) { [ weak self ] result in
            switch result {
            case .success(let data):
                if let resultString = String(data: data, encoding: .utf8) {
                    self?.serverIP = resultString
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func connectTCP(_ host: String) {
        client.connection!.connect(to: host, port: CommunicationPorts.tcpServer.rawValue)
    }
    
    func sendMessage(_ message: ChatMessage) {
        do {
            let procedure = Procedure(procedure: .message, parameter: message.content)
            let data = try procedure.encodeToJson()
            client.callProcedure(data)
                .sink { _ in
                } receiveValue: { data in
                    do {
                        let procedure = try Procedure<String>.decodeFromJson(data: data)
                        print(procedure)
                    } catch {
                        print(error)
                    }
                }
                .store(in: &cancellables)
        } catch {
            print(error)
        }
    }
    
    private func setSubscriptions() {
        self.client.connection!.statePublisher
            .sink { [weak self] state in
                if let newState = self?.clientMapper.mapToDomain(state) {
                    self?.statePublisher.send(newState)
                }
            }
            .store(in: &cancellables)
        
        self.client.connection!.messagePublisher
            .sink { [weak self] data in
                do {
                    let move = try Move.decodeFromJson(data: data)
                    self?.movePublisher.send(move)
                } catch {
                    print(error)
                    if let content = String(data: data, encoding: .utf8) {
                        if let status = MessagesType(rawValue: content) {
                            switch status {
                            case .START_GAME:
                                self?.statePublisher.send(.connectionReady)
                            case .FIRST_TO_CONNECT:
                                self?.statePublisher.send(.waitingConnection)
                            }
                        } else {
                            let newMessage = ChatMessage(
                                sender: .remoteUser,
                                content: content
                            )
                            self?.chatMessagePublisher.send(newMessage)
                        }
                    }
                }
                
                
            }
            .store(in: &cancellables)
    }
}

extension NetworkRepository {
    enum MessagesType: String {
        case START_GAME
        case FIRST_TO_CONNECT
    }
    
    enum CommunicationPorts: String {
        case broker = "1050"
        case tcpServer = "1100"
    }
    
    struct Procedure<Parameters: Codable>: Codable {
        let procedure: String
        let parameters: Parameters
        
        init(procedure: ProcedureTypes, parameter: Parameters) {
            self.procedure = procedure.rawValue
            self.parameters = parameter
        }
        
        enum ProcedureTypes: String {
            case move
            case message
        }
        
        func encodeToJson() throws -> Data {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(self)
        }
        
        static func decodeFromJson(data: Data) throws -> Procedure {
            let decoder = JSONDecoder()
            return try decoder.decode(Procedure.self, from: data)
        }
    }
}
