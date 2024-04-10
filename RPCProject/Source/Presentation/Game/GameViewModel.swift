//
//  GameViewModel.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var viewState: ViewState = .notStarted
    @Published var messages: [ChatMessage] = []
    @Published var inputUser: String = ""
    @Published var boardSpaces: [Int] = Array(repeating: 1, count: 33)
    @Published var selectedPiace: Int?
    @Published var avaliableMoviments: [Int]?
    @Published var ipAddress: String = "127.0.0.1"
    @Published var currentUserName: String = ""
    
    var isFirst: Bool = false
    @Published var isTurn: Bool = false
    var isWinner: Bool = false
    
    var neighBorOfSelected: [Int?]?
    
    private var connectionState: ConnectionState? {
        didSet {
            switch connectionState {
            case .firstToConnect:
                changeViewState(to: .inGame)
                isTurn = true
                isFirst = true
            case .startGame:
                changeViewState(to: .inGame)
            case .none:
                changeViewState(to: .notStarted)
            }
        }
    }
    var repository: (any NetworkRepositoryProtocol)?
    private var cancellables = Set<AnyCancellable>()
    
    func start() async {
        self.repository = NetworkRepository(
            chatClient: ChatgRPCCliente(host: ipAddress, port: NetworkRepository.CommunicationPorts.chatgRPC.rawValue),
            gameClient: GamegRPCClient(host: ipAddress, port: NetworkRepository.CommunicationPorts.gamegRPC.rawValue)
        )
        self.repository!.currentUser = currentUserName
        if let newState = await self.repository!.connect() {
            DispatchQueue.main.async {
                self.connectionState = newState
            }
        }
        setSubscriptions()
    }
    
    func sendMessage() async {
        let newMessage = ChatMessage(
            sender: .localUser,
            content: inputUser)
        await repository?.sendMessage(newMessage, userSender: currentUserName)
        DispatchQueue.main.async {
            self.inputUser = ""
        }
    }
    
    func receiveMessages() async {
        await repository?.receiveMessages()
    }
    
    func receiveMoves() async {
        await repository?.receiveMoves()
    }
    
    private func setSubscriptions() {
        repository?.chatMessagePublisher
            .sink { newMessage in
                DispatchQueue.main.async {
                    self.messages.append(newMessage)
                }
            }
            .store(in: &cancellables)
        
        repository?.movePublisher.sink { [weak self] move in
            DispatchQueue.main.async {
                self?.receiveMove(move)                
            }
        }
        .store(in: &cancellables)
    }
}

extension ViewModel {
    enum ViewState {
        case notStarted
        case loading
        case waitingPlayer
        case inGame
        case endGame
    }
    
    func changeViewState(to newState: ViewState) {
        DispatchQueue.main.async { [weak self] in
            self?.viewState = newState
        }
    }
    
    func changeIsWinner(to newValue: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isWinner = newValue
        }
    }
    
    func toggleIsTurn() {
        DispatchQueue.main.async { [weak self] in
            self?.isTurn.toggle()
        }
    }
}
