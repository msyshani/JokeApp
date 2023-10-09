//
//  MockDataManager.swift
//  JokeAppTests
//
//  Created by Mahendra Yadav on 07/10/23.
//

import Foundation
@testable import JokeApp

class MockDataManager: IDataManager {

    var invokedMaxLimitSetter = false
    var invokedMaxLimitSetterCount = 0
    var invokedMaxLimit: Int?
    var invokedMaxLimitList = [Int]()
    var invokedMaxLimitGetter = false
    var invokedMaxLimitGetterCount = 0
    var stubbedMaxLimit: Int! = 0

    var maxLimit: Int {
        set {
            invokedMaxLimitSetter = true
            invokedMaxLimitSetterCount += 1
            invokedMaxLimit = newValue
            invokedMaxLimitList.append(newValue)
        }
        get {
            invokedMaxLimitGetter = true
            invokedMaxLimitGetterCount += 1
            return stubbedMaxLimit
        }
    }

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
