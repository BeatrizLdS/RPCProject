//
//  NetworkProtocols.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import Foundation

protocol Comunication {
    func sendMessage(_ message: Data, completion: @escaping ((Bool) -> Void))
//    func receiveMessage()
}

protocol ClientProtocol: Comunication {
    associatedtype Connection
    var connection: Connection? { get set }
}
