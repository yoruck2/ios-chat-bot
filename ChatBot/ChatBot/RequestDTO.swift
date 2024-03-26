//
//  RequestDTO.swift
//  ChatBot
//
//  Created by dopamint on 3/26/24.
//

struct RequestDTO: Codable {
    let model: String
    let stream: Bool
    let messages: [MessagesDTO]
}

struct MessagesDTO : Codable {
    let role: String
    let content: String
}
