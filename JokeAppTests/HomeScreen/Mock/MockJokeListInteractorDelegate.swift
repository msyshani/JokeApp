//
//  MockJokeListInteractorDelegate.swift
//  JokeAppTests
//
//  Created by Mahendra Yadav on 06/10/23.
//

import Foundation
@testable import JokeApp

class MockJokeListInteractorDelegate: JokeListInteractorDelegate {

    var invokedJokeFetchSucceeded = false
    var invokedJokeFetchSucceededCount = 0
    var invokedJokeFetchSucceededParameters: (model: JokeModel, Void)?
    var invokedJokeFetchSucceededParametersList = [(model: JokeModel, Void)]()

    func jokeFetchSucceeded(with model: JokeModel) {
        invokedJokeFetchSucceeded = true
        invokedJokeFetchSucceededCount += 1
        invokedJokeFetchSucceededParameters = (model, ())
        invokedJokeFetchSucceededParametersList.append((model, ()))
    }

    var invokedJokeFetchFailed = false
    var invokedJokeFetchFailedCount = 0
    var invokedJokeFetchFailedParameters: (error: JokeError, Void)?
    var invokedJokeFetchFailedParametersList = [(error: JokeError, Void)]()

    func jokeFetchFailed(with error: JokeError) {
        invokedJokeFetchFailed = true
        invokedJokeFetchFailedCount += 1
        invokedJokeFetchFailedParameters = (error, ())
        invokedJokeFetchFailedParametersList.append((error, ()))
    }
}
