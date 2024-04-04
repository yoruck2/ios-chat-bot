//
//  MessageDTO+DictionaryRepresentation.swift
//  ChatBot
//
//  Created by nayeon  on 4/3/24.
//

extension MessageDTO {
    func dictionaryRepresentation() -> [String: Any] {
        return [
            "role": role.rawValue,
            "content": content
        ]
    }
}
