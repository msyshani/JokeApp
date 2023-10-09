//
//  MockNetworkService.swift
//  JokeAppTests
//
//  Created by Mahendra Yadav on 06/10/23.
//

import Foundation
@testable import JokeApp

class MockNetworkService: INetworkService {

    var invokedMakeRequest = false
    var invokedMakeRequestCount = 0
    var invokedMakeRequestParameters: (service: Any, Void)?
    var invokedMakeRequestParametersList = [(service: Any, Void)]()
    //var stubbedMakeRequestCompletionHandlerResult: (Result<T.ResponseDataType, JokeError>, Void)?

    func makeRequest<T: APIRequest>(service: T, completionHandler: @escaping (Result<T.ResponseDataType, JokeError>) -> Void) {
        invokedMakeRequest = true
        invokedMakeRequestCount += 1
        invokedMakeRequestParameters = (service, ())
        invokedMakeRequestParametersList.append((service, ()))
//        if let result = stubbedMakeRequestCompletionHandlerResult {
//            completionHandler(result.0)
//        }
    }
}
