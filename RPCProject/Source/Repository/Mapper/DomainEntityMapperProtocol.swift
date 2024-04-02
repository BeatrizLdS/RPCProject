//
//  DomainEntityMapperProtocol.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import Foundation

protocol DomainEntityMapper {
    associatedtype DTO
    associatedtype DomainEntity
    func mapToDomain(_ dto: DTO) -> DomainEntity
}
