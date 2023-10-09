//
//  StorageManager.swift
//  JokeApp
//
//  Created by Mahendra Yadav on 05/10/23.
//

import Foundation

protocol IStorageManager {
    func fetchAllJokes() -> [JokeModel]?
    func addNewJoke(model: JokeModel)
}

class StorageManager: IStorageManager {
    var dataManager: IDataManager
    
    init(dataManager: IDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchAllJokes() -> [JokeModel]? {
        dataManager.fetchAllJokes()
    }
    
    func addNewJoke(model: JokeModel) {
        dataManager.addNewJoke(model: model)
    }
}
