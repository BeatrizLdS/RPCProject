//
//  MoveMapper.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 03/04/24.
//

import Foundation

protocol MoveMapperProtocol: DomainEntityMapper where DTO == Data, DomainEntity == Move { }

//class MoveMapper: MoveMapperProtocol {
//    func mapToDomain(_ dto: Data) -> Move {
//        <#code#>
//    }
//}
