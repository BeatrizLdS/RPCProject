//
//  GamegRPCClient.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 08/04/24.
//

import Foundation
import GRPC
import NIOCore
import NIOPosix
import Combine

protocol GamegRPCClienteProtocol: ClientProtocol where Connection == ClientConnection {
    var movePublisher: PassthroughSubject<Game_Move, Never> { get set }
    var client: Game_GameServiceAsyncClient { get set }
    func connect(user: Game_User) async throws -> Game_GameState
    func sendMove(move: Game_Move) async
    func listenForMoves() async
}

class GamegRPCClient: GamegRPCClienteProtocol {
    var movePublisher = PassthroughSubject<Game_Move, Never>()
    
    var client: Game_GameServiceAsyncClient
    var connection: GRPC.ClientConnection?
    
    init(host: String, port: Int) {
        self.connection = ClientConnection.init(
            configuration: ClientConnection.Configuration(
                target: .hostAndPort(host, port),
                eventLoopGroup: MultiThreadedEventLoopGroup(numberOfThreads: 1)
            )
        )
        self.client = Game_GameServiceAsyncClient(channel: self.connection!)
    }
    
    func connect(user: Game_User) async throws -> Game_GameState {
        return (
            try await client.connect(user)
        )
    }
    
    func sendMove(move: Game_Move) async {
        do {
            let _ = try await client.sendMove(move)
        } catch {
            print(error)
        }
    }
    
    func listenForMoves() async {
        let result = client.gameStream(Game_Empty())
        var iterator = result.makeAsyncIterator()
        do {
            var move = try await iterator.next()
            while move != nil {
                movePublisher.send(move!)
                move = try await iterator.next()
            }
        } catch {
            print(error)
        }
    }
}
