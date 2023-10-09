//
//  JokeListInteractorTests.swift
//  JokeAppTests
//
//  Created by Mahendra Yadav on 06/10/23.
//

import XCTest
@testable import JokeApp

final class JokeListInteractorTests: XCTestCase {
    
    var interactor: JokeListInteractor!
    var mockNetworkService: MockNetworkService!
    var mockStorageManager: MockStorageManager!
    var interactorDelegate: MockJokeListInteractorDelegate!

    override func setUp() {
        mockNetworkService = MockNetworkService()
        mockStorageManager = MockStorageManager()
        interactorDelegate = MockJokeListInteractorDelegate()
        interactor = JokeListInteractor(networkService: mockNetworkService, storageManager: mockStorageManager)
        interactor.delegate = interactorDelegate
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRefreshJokes() {
        given("User open appliation") {
            self.when("App refresh joke from server") {
                self.interactor.refreshJokes()
                self.then("network api should be invoked", completion: {
                    XCTAssertTrue(self.mockNetworkService.invokedMakeRequest)
                    XCTAssertEqual(self.mockNetworkService.invokedMakeRequestCount, 1)
                })
            }
        }
    }
    
    func testFetchJokesFromLocalStorage() {
        given("User open appliation") {
            self.when("App try to fetch joke from storage") {
                _ = self.interactor.fetchJokesFromLocalStorage()
                self.then("Relavent func from Store manager should be invoked", completion: {
                    XCTAssertTrue(self.mockStorageManager.invokedFetchAllJokes)
                    XCTAssertEqual(self.mockStorageManager.invokedFetchAllJokesCount, 1)
                })
            }
        }
    }
    
    func testAddJokeInLocalStorage() {
        given("A joke fetched from setver") {
            self.when("App try to store joke in local stprage") {
                let model = JokeModel(joke: "Hello Joke", jokeTime: "now")
                self.interactor.addJokeInLocalStorage(model: model)
                self.then("Relavent func from Store manager should be invoked and joke should passed to storage service", completion: {
                    XCTAssertTrue(self.mockStorageManager.invokedAddNewJoke)
                    XCTAssertEqual(self.mockStorageManager.invokedAddNewJokeCount, 1)
                    XCTAssertEqual(self.mockStorageManager.invokedAddNewJokeParameters?.model.joke, "Hello Joke")
                    XCTAssertEqual(self.mockStorageManager.invokedAddNewJokeParameters?.model.jokeTime, "now")
                })
            }
        }
    }
}
