//
//  MoveMapper.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 03/04/24.
//

import Foundation
import GRPC

protocol MoveMapperProtocol: DomainEntityMapper where DTO == Game_Move, DomainEntity == Move { }

class MoveMapper: MoveMapperProtocol {
    func mapToDomain(_ dto: Game_Move) -> Move {
        return (
            Move(
                moveFrom: Int(exactly: dto.moveFrom) ,
                moveTo: Int(exactly: dto.moveTo),
                removed: Int(exactly: dto.removed),
                endGame: dto.endGame,
                retartGame: dto.restartGame
            )
        )
    }
}
