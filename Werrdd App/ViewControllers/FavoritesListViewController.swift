//
//  FavoritesListViewController.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/29/22.
//

import UIKit

class FavoritesListViewController: UIViewController {

    //MARK: - UI Properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return tableView
    }()
    
    
    //MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        tableView.dataSource = self
        tableView.delegate  = self
    }
}

extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
