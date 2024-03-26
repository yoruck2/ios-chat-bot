//
//  ResponseDTO.swift
//  ChatBot
//
//  Created by dopamint on 3/26/24.
//

struct ResponseDTO: Codable {
    let id: String
    let object: String
    let created: String
    let model: String
    let system_fingerprint: String
    let choices: [ChoicesDTO]
    let usage: [UsageDTO]
}

struct UsageDTO : Codable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}

struct ChoicesDTO : Codable {
    let index: Int
    let message: Int
    let finish_reason: String
}
