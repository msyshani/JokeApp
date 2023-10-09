//
//  UserDefautManager.swift
//  JokeApp
//
//  Created by Mahendra Yadav on 05/10/23.
//

import Foundation

protocol IDataManager {
    var maxLimit: Int { get set }
    func fetchAllJokes() -> [JokeModel]?
    func addNewJoke(model: JokeModel)
}

enum UserDefautKeys: String {
    case jokeList = "joke_app_joke_list"
}

class UserDefautManager: IDataManager {
    var maxLimit: Int
    let userDefault = UserDefaults.standard
    
    init(maxLimit: Int) {
        self.maxLimit = maxLimit
    }
    
    func fetchAllJokes() -> [JokeModel]? {
        if let array = userDefault.array(forKey: UserDefautKeys.jokeList.rawValue) as? [[String: String]] {
            return convertArrayToJokeModel(array: array)
        }
        return nil
    }
    
    func addNewJoke(model: JokeModel) {
        if var jokes = fetchAllJokes() {
            jokes.insert(model, at: 0)
            var array = convertJokeModelToArray(models: jokes)
            if array.count > maxLimit {
                array = Array(array.prefix(upTo: maxLimit))
            }
            userDefault.set(array, forKey: UserDefautKeys.jokeList.rawValue)
        } else {
            let array = convertJokeModelToArray(models: [model])
            userDefault.set(array, forKey: UserDefautKeys.jokeList.rawValue)
        }
    }
    
    private func convertJokeModelToArray(models: [JokeModel]) -> [[String: String]] {
        var array = [[String: String]]()
        
        for each in models {
            var dict = [String: String]()
            dict[JokeParsingKeys.joke.rawValue] = each.joke
            dict[JokeParsingKeys.time.rawValue] = each.jokeTime
            array.append(dict)
        }
        return array
    }
    
    private func convertArrayToJokeModel(array: [[String: String]]) -> [JokeModel] {
        var modelArray = [JokeModel]()
        
        for each in array {
            if let joke = each[JokeParsingKeys.joke.rawValue], let jokeTime = each[JokeParsingKeys.time.rawValue] {
                let model = JokeModel(joke: joke, jokeTime: jokeTime)
                modelArray.append(model)
            }
        }
        return modelArray
    }
}
