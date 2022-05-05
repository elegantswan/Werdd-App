//
//  FavoritesListViewController.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/29/22.
//

import UIKit

class FavoritesListViewController: UIViewController {
        
    private var favoritesList = [FavoritedWord]()
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConfiguration.backgroundColor
        addSubviews()
        setupNavigationItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DataManager.fetchFavoritedWords { [weak self] favoritedWords in
            guard let favoritedWords = favoritedWords else {
                return
            }
            self?.favoritesList = favoritedWords
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - UI Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate  = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIConfiguration.definitionCardBackground
        tableView.layer.cornerRadius = 10
        return tableView
    }()
    
    //MARK: - UI Setup
    private func addSubviews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationItems() {
        navigationController?.navigationBar.tintColor = UIConfiguration.definitionCardBackground
        navigationItem.title = "❤️Favorite Words❤️"
    }
}


extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let wordDetails = favoritesList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = UIConfiguration.definitionCardBackground
        
        cell.wordTitle.text = wordDetails.word
        cell.partOfSpeech.text = wordDetails.partOfSpeech
        cell.definition.text = wordDetails.definition
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let word = favoritesList[indexPath.row]
        
        navigationController?.pushViewController(FavoritedDetailViewController(selectedWord: word), animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
