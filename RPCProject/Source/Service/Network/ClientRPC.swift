//
//  ClientRPC.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import Foundation
import Combine

protocol ClientRPCProtocol: ClientProtocol where Connection == (any ClientTCPProtocol) {
    func callProcedure(_ data: Data) -> AnyPublisher<Data, Error>
}

class ClientRPC: ClientRPCProtocol {
    var connection: (any ClientTCPProtocol)?
    private var cancellables = Set<AnyCancellable>()
        
    init(connection: any ClientTCPProtocol) {
        self.connection = connection
    }
    
    func callProcedure(_ data: Data) -> AnyPublisher<Data, any Error> {
        return Future<Data, any Error> { promise in
            self.connection?.sendMessage(data) { sucess in
                if sucess {
                    self.connection?.messagePublisher.sink { dataFromService in
                        print(dataFromService)
                        promise(.success(dataFromService))
                    }
                    .store(in: &self.cancellables)
                } else {
                    promise(.failure(ErrorRPC.failedToSendMessage))
                }
            }
            
        }.eraseToAnyPublisher()
    }
}

enum ErrorRPC: Error {
    case failedToSendMessage
    case failedToConvertData
}
