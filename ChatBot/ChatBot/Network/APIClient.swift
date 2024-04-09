//
//  APIClient.swift
//  ChatBot
//
//  Created by nayeon  on 4/3/24.
//

import Alamofire

final class APIClient {
    static let shared = APIClient()
    
    func request<T: Decodable>(_ object: T.Type,
                               router: URLRequestConvertible,
                               completion: @escaping (NetworkResult<T>) -> Void) {
        AF.request(router)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: object) { response in
                switch response.result {
                case .success(let decodedData):
                    completion(.success(decodedData))
                case .failure(let error):
                    var errorMessage: String?
                    if let data = response.data, let message = String(data: data, encoding: .utf8) {
                        errorMessage = message
                    }
                    
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 400...499:
                            completion(.failure(.pathError(message: errorMessage)))
                        case 500...599:
                            completion(.failure(.serverError(message: errorMessage ?? "server error")))
                        default:
                            completion(.failure(.networkFail))
                        }
                    }
                }
            }
    }
}
