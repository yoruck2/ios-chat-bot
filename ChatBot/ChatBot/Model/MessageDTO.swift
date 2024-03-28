//
//  MessageDTO.swift
//  ChatBot
//
//  Created by nayeon  on 3/27/24.
//

struct MessageDTO: Codable {
    let role: Role
    let content: String
}

enum Role: String, Codable {
    case system = "system"
    case user = "user"
    case assistant = "assistant"
}