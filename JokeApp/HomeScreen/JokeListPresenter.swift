//
//  JokeListPresenter.swift
//  JokeApp
//
//  Created by Mahendra Yadav on 28/09/23.
//

import Foundation

class JokeListPresenter: IJokeListPresenter {
    private var view: IJokeListView
    private var interactor: IJokeListInteractor
    var jokeLimit = 10
    
    var jokeArray = [JokeModel]() {
        didSet {
            view.reloadData()
        }
    }
    
    init(_ view: IJokeListView, interactor: IJokeListInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        jokeArray = interactor.fetchJokesFromLocalStorage() ?? []
        interactor.startPolling()
    }
    
    var rowCount: Int {
        return jokeArray.count
    }
    
    func getJoke(at index: Int) -> JokeModel? {
        if index < jokeArray.count {
            return jokeArray[index]
        }
        return nil
    }
}

extension JokeListPresenter: JokeListInteractorDelegate {
    func jokeFetchSucceeded(with model: JokeModel) {
        jokeArray.insert(model, at: 0)
        if jokeArray.count > jokeLimit {
            jokeArray = Array(jokeArray.prefix(upTo: jokeLimit))
        }
        
    }
    
    func jokeFetchFailed(with error: JokeError) {
        DispatchQueue.main.async { [weak self] in
            self?.view.showError(error.message)
        }
    }
}
