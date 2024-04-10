//
//  APIConstants.swift
//  ChatBot
//
//  Created by nayeon  on 4/3/24.
//

import Foundation

enum APIConstants {
    static let baseURL = "https://api.openai.com"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}
