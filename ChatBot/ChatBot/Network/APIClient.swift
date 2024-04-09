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
                case .failure(_):
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 400...499:
                            completion(.failure(.pathError))
                        case 500...599:
                            completion(.failure(.serverError))
                        default:
                            completion(.failure(.networkFail))
                        }
                    } else {
                        completion(.failure(.networkFail))                
                    }
                }
            }
    }
}
