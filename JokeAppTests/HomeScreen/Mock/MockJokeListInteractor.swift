//
//  MockJokeListInteractor.swift
//  JokeAppTests
//
//  Created by Mahendra Yadav on 06/10/23.
//

import Foundation
@testable import JokeApp

class MockJokeListInteractor: IJokeListInteractor {

    var invokedStartPolling = false
    var invokedStartPollingCount = 0

    func startPolling() {
        invokedStartPolling = true
        invokedStartPollingCount += 1
    }

    var invokedFetchJokesFromLocalStorage = false
    var invokedFetchJokesFromLocalStorageCount = 0
    var stubbedFetchJokesFromLocalStorageResult: [JokeModel]!

    func fetchJokesFromLocalStorage() -> [JokeModel]? {
        invokedFetchJokesFromLocalStorage = true
        invokedFetchJokesFromLocalStorageCount += 1
        return stubbedFetchJokesFromLocalStorageResult
    }

    var invokedAddJokeInLocalStorage = false
    var invokedAddJokeInLocalStorageCount = 0
    var invokedAddJokeInLocalStorageParameters: (model: JokeModel, Void)?
    var invokedAddJokeInLocalStorageParametersList = [(model: JokeModel, Void)]()

    func addJokeInLocalStorage(model: JokeModel) {
        invokedAddJokeInLocalStorage = true
        invokedAddJokeInLocalStorageCount += 1
        invokedAddJokeInLocalStorageParameters = (model, ())
        invokedAddJokeInLocalStorageParametersList.append((model, ()))
    }
}
