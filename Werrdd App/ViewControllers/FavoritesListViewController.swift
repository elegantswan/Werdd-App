//
//  FavoritesListViewController.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/29/22.
//

import UIKit

struct FavoritesManager {
//    var favoritesList: [Word]
    var favoritesList = [Word]()
}

class FavoritesListViewController: UIViewController {
        
    private var favoritesList = [FavoritedWord]()
    
    //MARK: - UI Properties
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "Rubik-Bold", size: 25)
        title.text = "📝Favorites📝"
        return title
    }()
    
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
    
    //MARK: - Initializer
    
//    init(favorites: [FavoritedWord]) {
//        self.favoritesList = favorites
//        
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConfiguration.backgroundColor
        addSubviews()
        navigationController?.navigationBar.tintColor = UIConfiguration.definitionCardBackground

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
    
    //MARK: - UI Setup
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Need to access element based on their indexPath
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
}
