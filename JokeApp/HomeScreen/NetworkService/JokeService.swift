//
//  JokeService.swift
//  JokeApp
//
//  Created by Mahendra Yadav on 04/10/23.
//

import Foundation

class JokeService: APIRequest {
    
    enum ApiEndPoint: String {
        case joke = "https://geek-jokes.sameerkumar.website/api"
    }
    
    func makeRequest() -> URLRequest? {
        guard let url = URL(string: ApiEndPoint.joke.rawValue) else {
            return nil
        }
        
        let request = URLRequest(url: url)
        return request
    }
    
    func parseResponse(_ responseData: Data) -> JokeModel? {
        if let str = String(data: responseData, encoding: .utf8) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            
            let date = dateFormatter.string(from: Date())
            
            let model = JokeModel(joke: str, jokeTime: date)
            return model
        } else {
            return nil
        }
    }
}
