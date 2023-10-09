//
//  MockStorageManager.swift
//  JokeAppTests
//
//  Created by Mahendra Yadav on 06/10/23.
//

import Foundation
@testable import JokeApp

class MockStorageManager: IStorageManager {

    var invokedFetchAllJokes = false
    var invokedFetchAllJokesCount = 0
    var stubbedFetchAllJokesResult: [JokeModel]!

    func fetchAllJokes() -> [JokeModel]? {
        invokedFetchAllJokes = true
        invokedFetchAllJokesCount += 1
        return stubbedFetchAllJokesResult
    }

    var invokedAddNewJoke = false
    var invokedAddNewJokeCount = 0
    var invokedAddNewJokeParameters: (model: JokeModel, Void)?
    var invokedAddNewJokeParametersList = [(model: JokeModel, Void)]()

    func addNewJoke(model: JokeModel) {
        invokedAddNewJoke = true
        invokedAddNewJokeCount += 1
        invokedAddNewJokeParameters = (model, ())
        invokedAddNewJokeParametersList.append((model, ()))
    }
}
