//
//  ResponseDTO.swift
//  ChatBot
//
//  Created by dopamint on 3/26/24.
//

struct ResponseDTO: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: GPTModel
    let systemFingerprint: String
    let choices: [ChoiceDTO]
    let usage: UsageDTO
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case created
        case model
        case choices
        case usage
        case systemFingerprint = "system_fingerprint"
    }

}

struct UsageDTO: Decodable {
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int
    
    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}

struct ChoiceDTO: Decodable {
    let index: Int
    let message: MessageDTO
    let logprobs: String?
    let finishReason: String
    
    enum CodingKeys: String, CodingKey {
        case index
        case message
        case logprobs
        case finishReason = "finish_reason"
    }
}
