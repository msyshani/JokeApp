//
//  NetworkServiceTest.swift
//  JokeAppTests
//
//  Created by Mahendra Yadav on 07/10/23.
//

import XCTest
@testable import JokeApp

final class NetworkServiceTest: XCTestCase {
    
    var networkService: NetworkService!
    var mockUrlProtocol: MockURLProtocol!
    
    func getURLSessionWithMockConfigurations() -> URLSession {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [MockURLProtocol.self]
            let urlSession = URLSession(configuration: configuration)
            return urlSession
    }
    
    override func setUp() {
        mockUrlProtocol = MockURLProtocol()
        let urlSession = getURLSessionWithMockConfigurations()
        networkService = NetworkService(urlSession)
    }
    
    func testMakeRequest() {
        given("") {
            self.when("") {
                let response = "This Jokes is new and fresh"
                let data = response.data(using: .utf8)!
                MockURLProtocol.requestHandler = { request in
                    let response = HTTPURLResponse(url: URL(string: "https://geek-jokes.sameerkumar.website/api")!,
                                                   statusCode: 200,
                                                   httpVersion: nil,
                                                   headerFields: ["Content-Type": "application/json"])!
                    return (response, data)
                }
                
                let sucessExpectation = self.expectation(description: "should succeed")
                
                self.then("", completion: {
                    let apiRequest = JokeService()
                    self.networkService.makeRequest(service: apiRequest) { result in
                        switch result {
                        case .success(let joke):
                            sucessExpectation.fulfill()
                            XCTAssertEqual(joke.joke, "This Jokes is new and fresh")
                        case .failure(_):
                            break
                        }
                    }
                    self.wait(for: [sucessExpectation], timeout: 2.0)
                })
            }
        }
    }
}
