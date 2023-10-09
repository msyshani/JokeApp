//
//  StorageManagerTests.swift
//  JokeAppTests
//
//  Created by Mahendra Yadav on 07/10/23.
//

import XCTest
@testable import JokeApp

final class StorageManagerTests: XCTestCase {
    
    var storageManager: StorageManager!
    var mockDataManager: MockDataManager!

    override func setUp() {
        mockDataManager = MockDataManager()
        storageManager = StorageManager(dataManager: mockDataManager)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchAllJokes() {
        given("User open application") {
            self.when("App try to load saved jokes and no jokes stored in storage") {
                self.mockDataManager.stubbedFetchAllJokesResult = []
                let jokes = self.storageManager.fetchAllJokes()
                self.then("Result should be empty", completion: {
                    XCTAssertTrue(self.mockDataManager.invokedFetchAllJokes)
                    XCTAssertEqual(self.mockDataManager.invokedFetchAllJokesCount, 1)
                    XCTAssertEqual(jokes?.count, 0)
                })
            }
            
            self.when("App try to load saved jokes and one joke stored in storage") {
                self.mockDataManager.stubbedFetchAllJokesResult = [JokeModel(joke: "New joke", jokeTime: "now")]
                let jokes = self.storageManager.fetchAllJokes()
                self.then("Result should contains 1 joke", completion: {
                    XCTAssertTrue(self.mockDataManager.invokedFetchAllJokes)
                    XCTAssertEqual(self.mockDataManager.invokedFetchAllJokesCount, 2)
                    XCTAssertEqual(jokes?.count, 1)
                    XCTAssertEqual(jokes?.first?.joke, "New joke")
                    XCTAssertEqual(jokes?.first?.jokeTime, "now")
                })
            }
        }
    }
    
    func testAddNewJoke() {
        given("App fetch a joke from server") {
            self.when("App try to store joke in stored") {
                let model = JokeModel(joke: "New joke", jokeTime: "now")
                self.storageManager.addNewJoke(model: model)
                self.then("Joke should store in storage", completion: {
                    XCTAssertTrue(self.mockDataManager.invokedAddNewJoke)
                    XCTAssertEqual(self.mockDataManager.invokedAddNewJokeCount, 1)
                    XCTAssertEqual(self.mockDataManager.invokedAddNewJokeParameters?.model.joke, "New joke")
                    XCTAssertEqual(self.mockDataManager.invokedAddNewJokeParameters?.model.jokeTime, "now")
                })
            }
        }
    }

}
