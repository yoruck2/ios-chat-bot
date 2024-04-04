//
//  AppConfig.swift
//  ChatBot
//
//  Created by nayeon  on 4/4/24.
//

import Foundation

enum AppConfig {
    static var openAIAPIKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            assertionFailure("API_KEY를 찾을 수 없음")
            return ""
        }
        return key
    }
}
