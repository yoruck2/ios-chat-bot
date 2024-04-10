//
//  RequestDTO.swift
//  ChatBot
//
//  Created by dopamint on 3/26/24.
//

protocol DictionaryRepresentable {
    func dictionaryRepresentation() -> [String: Any]
}

struct RequestDTO: Encodable, DictionaryRepresentable {
    let model: GPTModel
    let stream: Bool
    let messages: [MessageDTO]
}

enum GPTModel: String, Codable {
    case basic = "gpt-3.5-turbo-1106"
}
