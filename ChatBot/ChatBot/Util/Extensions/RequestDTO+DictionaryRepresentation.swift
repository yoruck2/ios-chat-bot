//
//  RequestDTO+DictionaryRepresentation.swift
//  ChatBot
//
//  Created by nayeon  on 4/3/24.
//

extension RequestDTO {
    func dictionaryRepresentation() -> [String: Any] {
        var parameters: [String: Any] = [:]
        
        parameters["model"] = model.rawValue
        parameters["stream"] = stream
        parameters["messages"] = messages.map { $0.dictionaryRepresentation() }
        
        return parameters
    }
}
