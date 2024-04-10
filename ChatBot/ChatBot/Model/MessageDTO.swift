//
//  MessageDTO.swift
//  ChatBot
//
//  Created by nayeon  on 3/27/24.
//

struct MessageDTO: Codable, DictionaryRepresentable {
    let role: Role
    let content: String
}

enum Role: String, Codable {
    case system
    case user
    case assistant
}
