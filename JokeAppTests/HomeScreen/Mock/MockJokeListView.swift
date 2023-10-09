//
//  MockJokeListView.swift
//  JokeAppTests
//
//  Created by Mahendra Yadav on 06/10/23.
//

import Foundation
@testable import JokeApp

class MockJokeListView: IJokeListView {

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }

    var invokedShowError = false
    var invokedShowErrorCount = 0
    var invokedShowErrorParameters: (message: String, Void)?
    var invokedShowErrorParametersList = [(message: String, Void)]()

    func showError(_ message: String) {
        invokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (message, ())
        invokedShowErrorParametersList.append((message, ()))
    }
}
