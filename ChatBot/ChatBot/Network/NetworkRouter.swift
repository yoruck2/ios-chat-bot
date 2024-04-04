//
//  NetworkRouter.swift
//  ChatBot
//
//  Created by nayeon  on 4/3/24.
//

import Alamofire

protocol NetworkRouter {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
}
