//
//  ConnectionStateMapper.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import Foundation
import Network

protocol ClientStateMapperProtocol: DomainEntityMapper where DTO == NWConnection.State, DomainEntity == ConnectionState { }

class ClientStateMapper: ClientStateMapperProtocol {
    func mapToDomain(_ dto: NWConnection.State) -> ConnectionState {
        switch dto {
        case .preparing:
            return .loadingConnection
        case .ready:
            return .connectionReady
        case .cancelled:
            return .connectionCancelled
        default:
            return .connectionError
        }
    }
}
