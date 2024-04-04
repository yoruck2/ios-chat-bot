//
//  APIRouter.swift
//  ChatBot
//
//  Created by nayeon  on 4/3/24.
//

import Alamofire

enum APIRouter: NetworkRouter {
    case chatCompletion(requestDTO: RequestDTO)
    
    var baseURL: String {
        return APIConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .chatCompletion:
            return "/v1/chat/completions"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .chatCompletion:
            return .post
        }
    }
    
    var headers: [String: String] {
        return [
            HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
            HTTPHeaderField.authentication.rawValue: "Bearer \(AppConfig.openAIAPIKey)"
        ]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .chatCompletion(let requestDTO):
            return requestDTO.dictionaryRepresentation()
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .chatCompletion:
            return JSONEncoding.default
        }
    }
}

extension APIRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        if let parameters = parameters {
            urlRequest = try encoding.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
