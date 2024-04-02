//
//  ChatMessage.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import Foundation

struct ChatMessage: Hashable {
    var sender: SenderType
    var content: String
    
    enum SenderType {
        case localUser
        case remoteUser
    }
}
