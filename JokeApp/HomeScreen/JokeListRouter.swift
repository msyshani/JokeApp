//
//  JokeListRouter.swift
//  JokeApp
//
//  Created by Mahendra Yadav on 03/10/23.
//

import Foundation
import UIKit

class JokeListRouter {
    
    func createJokeListView() -> UIViewController {
        let networkService = NetworkService(URLSession.shared)
        let dataManager = UserDefautManager(maxLimit: 10)
        let storageManager = StorageManager(dataManager: dataManager)
        
        let vc = JokeListViewController()
        let interator = JokeListInteractor(networkService: networkService, storageManager: storageManager)
        let presenter = JokeListPresenter(vc, interactor: interator)
        interator.delegate = presenter
        vc.presenter = presenter
        return vc
    }
}

extension JokeListRouter {
    func openJokeList(from navigationController: UINavigationController) {
        let vc = createJokeListView()
        navigationController.show(vc, sender: nil)
    }
}
