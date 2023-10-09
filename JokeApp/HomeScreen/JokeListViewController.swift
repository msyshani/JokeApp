//
//  JokeListViewController.swift
//  JokeApp
//
//  Created by Mahendra Yadav on 02/10/23.
//

import UIKit

class JokeListViewController: UIViewController {
    
    var presenter: IJokeListPresenter?
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func loadView() {
        view = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        addConstraintsOnTableView()
        registerTableViewCell()
    }
    
    private func addConstraintsOnTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func registerTableViewCell() {
        tableView.register(JokeTableViewCell.self, forCellReuseIdentifier: HomeScreen.JokeCellReuseIdentifier.rawValue)
    }
}

extension JokeListViewController: IJokeListView {
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showError(_ message: String) {
        let alertController = UIAlertController(title: "Opps! Something went wrong",
                                                message: message,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok, Got it", style: .cancel) { _ in }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension JokeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.rowCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: JokeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeScreen.JokeCellReuseIdentifier.rawValue, for: indexPath) as? JokeTableViewCell {
            if let model = presenter?.getJoke(at: indexPath.row) {
                cell.configureData(from: model)
            }
            return cell
        }
        return UITableViewCell()
        
    }
}
