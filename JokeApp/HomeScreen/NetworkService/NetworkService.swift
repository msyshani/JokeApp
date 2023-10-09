//
//  NetworkService.swift
//  JokeApp
//
//  Created by Mahendra Yadav on 05/10/23.
//

import Foundation

protocol INetworkService {
    func makeRequest<T: APIRequest>(service: T, completionHandler: @escaping (Result<T.ResponseDataType, JokeError>) -> Void)
}

enum JokeError: Error {
    case noNetwork
    case invalidUrl
    case ParsingError
    case apiError
    
    var message: String {
        switch self {
        case .noNetwork:
            return "please check your network connection"
        case .ParsingError, .apiError, .invalidUrl:
            return "Wait.. we are fixing it"
        }
    }
}

protocol APIRequest {
    
    associatedtype ResponseDataType
   
    func makeRequest() -> URLRequest?
    func parseResponse(_ responseData: Data) -> ResponseDataType?
}

class NetworkService: INetworkService {
    
    let urlSession: URLSession
    
    init(_ urlSession: URLSession) {
        self.urlSession = urlSession
    }
   
    
    func makeRequest<T: APIRequest>(service: T, completionHandler: @escaping (Result<T.ResponseDataType, JokeError>) -> Void) {
        guard let urlRequest = service.makeRequest() else {
            return
        }
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            
            guard let responseData = data else {
                completionHandler(.failure(.ParsingError))
                return
            }
            
            if let result = service.parseResponse(responseData) {
                DispatchQueue.main.async {
                    completionHandler(.success(result))
                }
            } else {
                completionHandler(.failure(.ParsingError))
            }
        }
        task.resume()
    }
}
