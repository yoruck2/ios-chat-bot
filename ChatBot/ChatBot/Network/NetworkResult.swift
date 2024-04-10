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
    case pathError(message: String?)
    case serverError(message: String?)
    case networkFail
}
