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

protocol GamegRPCClienteProtocol: ClientProtocol where Connection == ClientConnection {
    var client: Game_GameServiceAsyncClient { get set }
    func connect(user: Game_User) async
}

class GamegRPCClient: GamegRPCClienteProtocol {
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
    
    func connect(user: Game_User) async {
        do {
            let result = try await client.connect(user)
            print(result)
        } catch {
            print(error)
        }
    }
}
