//
//  ChatMessage.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import Foundation

struct ChatMessage: Hashable, Codable {
    var sender: String
    var content: String
    
    init(sender: SenderType, content: String) {
        self.sender = sender.rawValue
        self.content = content
    }
    
    enum SenderType: String {
        case localUser
        case remoteUser
    }
    
    static func decodeFromJson(data: Data) throws -> ChatMessage {
        let decoder = JSONDecoder()
        return try decoder.decode(ChatMessage.self, from: data)
    }
}
