//
//  JokeListInteractor.swift
//  JokeApp
//
//  Created by Mahendra Yadav on 04/10/23.
//

import Foundation

protocol JokeListInteractorDelegate: AnyObject {
    func jokeFetchSucceeded(with model: JokeModel)
    func jokeFetchFailed(with error: JokeError)
}

class JokeListInteractor: IJokeListInteractor {
    weak var presenter: IJokeListPresenter?
    weak var delegate: JokeListInteractorDelegate?
    private var networkService: INetworkService
    private var storageManager: IStorageManager
    
    
    init(networkService: INetworkService, storageManager: IStorageManager) {
        self.networkService = networkService
        self.storageManager = storageManager
    }
    
    let pollingTimeInterval = 10.0
    private var timer: Timer?
    
    func startPolling() {
        refreshJokes()
        timer = Timer.scheduledTimer(timeInterval: pollingTimeInterval, target: self, selector: #selector(refreshJokes), userInfo: nil, repeats: true)
    }
    
    @objc func refreshJokes() {
        let jokeService = JokeService()
        networkService.makeRequest(service: jokeService) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.jokeFetchSucceeded(with: model)
                self?.addJokeInLocalStorage(model: model)
            case .failure(let error):
                self?.delegate?.jokeFetchFailed(with: error)
            }
        }
    }
    
    func fetchJokesFromLocalStorage() -> [JokeModel]? {
        storageManager.fetchAllJokes()
    }
    
    func addJokeInLocalStorage(model: JokeModel) {
        storageManager.addNewJoke(model: model)
    }
    
    deinit {
        timer?.invalidate()
    }
}
