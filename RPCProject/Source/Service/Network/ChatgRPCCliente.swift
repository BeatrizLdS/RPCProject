//
//  ClienteRPC.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 06/04/24.
//

import Foundation
import GRPC
import NIOCore
import NIOPosix
import Combine

protocol ChatgRPCClienteProtocol: ClientProtocol where Connection == ClientConnection {
    var chatMessagePublisher: PassthroughSubject<Chat_ChatMessage, Never> { get set }
    
    var client: Chat_ChatServiceAsyncClient? { get set }
    func sendMessage(message: Chat_ChatMessage) async throws -> Chat_ChatMessage
    func listenForMessages() async
}

class ChatgRPCCliente: ChatgRPCClienteProtocol {
    var chatMessagePublisher = PassthroughSubject<Chat_ChatMessage, Never>()
    
    var connection: ClientConnection?
    var client: Chat_ChatServiceAsyncClient?
    private var cancellables = Set<AnyCancellable>()
    
    init(host: String, port: Int) {
        self.connection = ClientConnection.init(
            configuration: ClientConnection.Configuration(
                target: .hostAndPort(host, port),
                eventLoopGroup: MultiThreadedEventLoopGroup(numberOfThreads: 1)
            )
        )
        self.client = Chat_ChatServiceAsyncClient(channel: self.connection!)
    }
    
    func sendMessage(message: Chat_ChatMessage) async throws -> Chat_ChatMessage {
        return (
            try await client?.sendMessage(message)
        )!
    }
    
    func listenForMessages() async {
        let result = client?.chatStream(Chat_Empty())
        var iterator = result?.makeAsyncIterator()
        do {
            var message = try await iterator?.next()
            while message != nil {
                chatMessagePublisher.send(message!)
                message = try await iterator?.next()
            }
            
        } catch {
            print(error)
        }
    }
}
