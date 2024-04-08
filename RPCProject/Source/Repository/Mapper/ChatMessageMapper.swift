//
//  ChatMessageMapper.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 08/04/24.
//

import Foundation
import GRPC

protocol ChatMessageLocalMapperProtocol: DomainEntityMapper where DTO == Chat_ChatMessage, DomainEntity == ChatMessage { }

class ChatMessageLocalMapper: ChatMessageLocalMapperProtocol {
    func mapToDomain(_ dto: Chat_ChatMessage) -> ChatMessage {
        return ChatMessage(
            sender: ChatMessage.SenderType.localUser,
            content: dto.text
        )
    }
}

protocol ChatMessageRemoteMapperProtocol: DomainEntityMapper where DTO == Chat_ChatMessage, DomainEntity == ChatMessage { }

class ChatMessageRemoteMapper: ChatMessageRemoteMapperProtocol {
    func mapToDomain(_ dto: Chat_ChatMessage) -> ChatMessage {
        return ChatMessage(
            sender: ChatMessage.SenderType.remoteUser,
            content: dto.text
        )
    }
}
