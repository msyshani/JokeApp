//
//  JokeListContract.swift
//  JokeApp
//
//  Created by Mahendra Yadav on 02/10/23.
//

import Foundation

protocol IJokeListPresenter: AnyObject {
    var rowCount: Int { get }
    func getJoke(at index: Int) -> JokeModel?
    
    func viewDidLoad()
}

protocol IJokeListView: AnyObject {
    func reloadData()
    func showError(_ message: String)
}

protocol IJokeListInteractor: AnyObject {
    func startPolling()
    func fetchJokesFromLocalStorage() -> [JokeModel]?
    func addJokeInLocalStorage(model: JokeModel)
}
