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
    @Published var currentUserName: String = "" {
        didSet {
            repository.currentUser = currentUserName
        }
    }
    
    var isFirst: Bool = false
    @Published var isTurn: Bool = false
    var isWinner: Bool = false
    
    var neighBorOfSelected: [Int?]?
    
    private var connectionState: ConnectionState? {
        didSet {
            switch connectionState {
            case .waitingConnection:
                viewState = .waitingPlayer
                isTurn = true
                isFirst = true
            case .serverReady:
                viewState = .waitingPlayer
            case .connectionReady:
                viewState = .inGame
            case .loadingConnection:
                viewState = .loading
            default:
                break
            }
        }
    }
    var repository: any NetworkRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: any NetworkRepositoryProtocol) {
        self.repository = repository
        setSubscriptions()
    }
    
    func start() {
        viewState = .inGame
    }
    
    func sendMessage() async {
        let newMessage = ChatMessage(
            sender: .localUser,
            content: inputUser)
        await repository.sendMessage(newMessage, userSender: currentUserName)
        DispatchQueue.main.async {
            self.inputUser = ""
        }
    }
    
    func receiveMessages() async {
        await repository.receiveMessages()
    }
    
    private func setSubscriptions() {
        repository.chatMessagePublisher
            .sink { newMessage in
                DispatchQueue.main.async {
                    self.messages.append(newMessage)
                }
            }
            .store(in: &cancellables)
        
        repository.movePublisher.sink { [weak self] move in
            self?.receiveMove(move)
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
}
