//
//  NetworkProtocols.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import Foundation

protocol ClientProtocol {
    associatedtype Connection
    var connection: Connection? { get set }
}
