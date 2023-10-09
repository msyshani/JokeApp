//
//  JokeListPresenterTests.swift
//  JokeAppTests
//
//  Created by Mahendra Yadav on 06/10/23.
//

import XCTest
@testable import JokeApp

final class JokeListPresenterTests: XCTestCase {
    
    var presenter: JokeListPresenter!
    var mockView: MockJokeListView!
    var mockInteractor: MockJokeListInteractor!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockView = MockJokeListView()
        mockInteractor = MockJokeListInteractor()
        presenter = JokeListPresenter(mockView, interactor: mockInteractor)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testJokeArraySetter() {
        given("User is on Joke Home screen") {
            self.when("") {
                self.presenter.jokeArray = [JokeModel(joke: "", jokeTime: "")]
                self.then("", completion: {
                    XCTAssertTrue(self.mockView.invokedReloadData)
                    XCTAssertEqual(self.mockView.invokedReloadDataCount, 1)
                })
            }
        }
    }
    
    func testViewDidLoad() {
        given("User is on Joke Home screen") {
            self.when("") {
                self.presenter.viewDidLoad()
                self.then("", completion: {
                    XCTAssertTrue(self.mockInteractor.invokedFetchJokesFromLocalStorage)
                    XCTAssertEqual(self.mockInteractor.invokedFetchJokesFromLocalStorageCount, 1)
                })
                
                self.then("Polling should start", completion: {
                    XCTAssertTrue(self.mockInteractor.invokedStartPolling)
                    XCTAssertEqual(self.mockInteractor.invokedStartPollingCount, 1)
                })
            }
        }
    }
    
    func testRowCount() {
        given("") {
            self.when("") {
                self.presenter.jokeArray = [JokeModel(joke: "", jokeTime: "")]
                let count = self.presenter.rowCount
                self.then("", completion: {
                    XCTAssertEqual(count, 1)
                })
            }
            
            self.when("") {
                self.presenter.jokeArray = [JokeModel(joke: "", jokeTime: ""), JokeModel(joke: "", jokeTime: "")]
                let count = self.presenter.rowCount
                self.then("", completion: {
                    XCTAssertEqual(count, 2)
                })
            }
        }
    }
    
    func testGetJoke() {
        given("") {
            self.when("") {
                self.presenter.jokeArray = [JokeModel(joke: "Hi Jokes", jokeTime: "06 Oct")]
                let joke = self.presenter.getJoke(at: 0)
                self.then("", completion: {
                    XCTAssertEqual(joke?.joke, "Hi Jokes")
                    XCTAssertEqual(joke?.jokeTime, "06 Oct")
                })
            }
            
            self.when("") {
                self.presenter.jokeArray = [JokeModel(joke: "Hi Jokes", jokeTime: "06 Oct"), JokeModel(joke: "Second Joke", jokeTime: "07 Oct")]
                let joke = self.presenter.getJoke(at: 1)
                self.then("", completion: {
                    XCTAssertEqual(joke?.joke, "Second Joke")
                    XCTAssertEqual(joke?.jokeTime, "07 Oct")
                })
            }
            
            self.when("") {
                self.presenter.jokeArray = [JokeModel(joke: "Hi Jokes", jokeTime: "06 Oct"), JokeModel(joke: "Second Joke", jokeTime: "07 Oct")]
                let joke = self.presenter.getJoke(at: 2)
                self.then("", completion: {
                    XCTAssertNil(joke)
                })
            }
        }
    }
    
    func testJokeFetchSucceeded() {
        given("") {
            self.when("") {
                let model = JokeModel(joke: "My Joke", jokeTime: "Today")
                self.presenter.jokeFetchSucceeded(with: model)
                self.then("", completion: {
                    XCTAssertEqual(self.presenter.jokeArray.count, 1)
                })
            }
            
            self.when("") {
                for _ in 0 ... 9 {
                    self.presenter.jokeArray.append(JokeModel(joke: "My Joke", jokeTime: "Today"))
                }
                let model = JokeModel(joke: "My Joke", jokeTime: "Today")
                self.presenter.jokeFetchSucceeded(with: model)
                self.then("", completion: {
                    XCTAssertEqual(self.presenter.jokeArray.count, 10)
                })
            }
            
            self.when("") {
                for _ in 0 ... 10 {
                    self.presenter.jokeArray.append(JokeModel(joke: "My Joke", jokeTime: "Today"))
                }
                let model = JokeModel(joke: "New Joke again", jokeTime: "Now")
                self.presenter.jokeFetchSucceeded(with: model)
                self.then("", completion: {
                    XCTAssertEqual(self.presenter.jokeArray.count, 10)
                    let firstJoke = self.presenter.jokeArray.first
                    XCTAssertEqual(firstJoke?.joke, "New Joke again")
                    XCTAssertEqual(firstJoke?.jokeTime, "Now")
                    
                })
            }
        }
    }
}


extension XCTestCase {
    func given(_: String, completion: @escaping (() -> Void)) {
        setUp()
        completion()
        tearDown()
    }

    func when(_: String, completion: @escaping (() -> Void)) { completion() }
    func then(_: String, completion: @escaping (() -> Void)) { completion() }

    func eventually(timeout: TimeInterval = 0.01, closure: @escaping () -> Void) {
        let expectation = self.expectation(description: "Tests expectation")
        expectation.fulfillAfter(timeout)
        waitForExpectations(timeout: 60) { _ in
            closure()
        }
    }
}

extension XCTestExpectation {
    func fulfillAfter(_ time: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.fulfill()
        }
    }
}


