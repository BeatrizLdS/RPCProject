//
//  Repository.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import Foundation

import Network
import Combine
import GRPC
import NIOCore
import NIOPosix

protocol NetworkRepositoryProtocol {    
    var currentUser: String { get set }
    var chatMessagePublisher: PassthroughSubject<ChatMessage, Never> { get set }
    var movePublisher: PassthroughSubject<Move, Never> { get set }
    
    func connect() async -> ConnectionState?
    func sendMessage(_ message: ChatMessage, userSender: String) async
    func sendMove(_ move: Move)
    func receiveMessages() async
}

class NetworkRepository: NetworkRepositoryProtocol {
    var currentUser: String = ""

    private var chatClient: any ChatgRPCClienteProtocol
    private var gameClient: any GamegRPCClienteProtocol
    
    private var chatLocalMapper: any ChatMessageLocalMapperProtocol = ChatMessageLocalMapper()
    private var chatRemoteMapper: any ChatMessageRemoteMapperProtocol = ChatMessageRemoteMapper()
    private var gameConnectionMapper: any ClientStateMapperProtocol = ClientStateMapper()
    
    var chatMessagePublisher = PassthroughSubject<ChatMessage, Never>()
    var movePublisher = PassthroughSubject<Move, Never>()
    
    private var cancellables = Set<AnyCancellable>()
        
    required init(
        chatClient: any ChatgRPCClienteProtocol,
        gameClient: any GamegRPCClienteProtocol
    ) {
        self.chatClient = chatClient
        self.gameClient = gameClient
        setSubscriptions()
    }
    
    func sendMove(_ move: Move) {

    }
    
    func connect() async -> ConnectionState? {
        do {
            let request = Game_User.with { request in
                request.name = currentUser
            }
            let result = try await gameClient.connect(user: request)
            let state = gameConnectionMapper.mapToDomain(StateConnectType(rawValue: result.state)!)
            return state
        } catch {
            print(error)
        }
        return nil
    }
    
    func sendMessage(_ message: ChatMessage, userSender: String) async {
        do {
            let chatRequest = Chat_ChatMessage.with { request in
                request.text = message.content
                request.sender = userSender
            }
            let _ = try await chatClient.sendMessage(message: chatRequest)
        } catch {}
    }
    
    func receiveMessages() async {
        await chatClient.listenForMessages()
    }
    
    func setSubscriptions() {
        chatClient.chatMessagePublisher
            .sink { [weak self] chat_message in
                if chat_message.sender == self?.currentUser {
                    if let chatMessage = self?.chatLocalMapper.mapToDomain(chat_message) {
                        self?.chatMessagePublisher.send(chatMessage)
                    }
                } else {
                    if let chatMessage = self?.chatRemoteMapper.mapToDomain(chat_message) {
                        self?.chatMessagePublisher.send(chatMessage)
                    }
                }
            }
            .store(in: &cancellables)
    }
}

extension NetworkRepository {
    enum StateConnectType: String {
        case START_GAME
        case FIRST_TO_CONNECT
    }
    
    enum CommunicationPorts: Int {
        case gamegRPC = 1200
        case chatgRPC = 1100
    }
}
