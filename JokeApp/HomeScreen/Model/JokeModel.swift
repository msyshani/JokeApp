//
//  JokeModel.swift
//  JokeApp
//
//  Created by Mahendra Yadav on 06/10/23.
//

import Foundation

struct JokeModel {
    var joke: String
    var jokeTime: String
    
    init(joke: String, jokeTime: String) {
        self.joke = joke
        self.jokeTime = jokeTime
    }
}
