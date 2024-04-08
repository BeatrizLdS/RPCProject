//
//  ConnectionStateMapper.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import Foundation
import Network

protocol ClientStateMapperProtocol: DomainEntityMapper where DTO == NetworkRepository.StateConnectType, DomainEntity == ConnectionState { }

class ClientStateMapper: ClientStateMapperProtocol {
    func mapToDomain(_ dto: NetworkRepository.StateConnectType) -> ConnectionState {
        switch dto {
        case .START_GAME:
            return .startGame
        case .FIRST_TO_CONNECT:
            return .firstToConnect
        }
    }
}
