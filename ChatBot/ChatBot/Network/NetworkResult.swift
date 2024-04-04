//
//  NetworkResult.swift
//  ChatBot
//
//  Created by nayeon  on 4/3/24.
//

enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: Error {
    case requestError
    case pathError
    case parsingError
    case serverError
    case networkFail
}
