//
//  ViewController.swift
//  Werrdd App
//
//  Created by Kevin Phan on 3/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    let spinnerView = SpinnerViewController()
    var wordDetails = [Word]()
    
    //MARK: - UI Properties
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 25
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIConfiguration.backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 25
        tableView.allowsSelection = true
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.text = "Werrdd"
        return label
    }()
    
    lazy var definitionCard : UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 25
        card.backgroundColor = UIConfiguration.definitionCardBackground
        return card
    }()
    
    lazy var word: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Random Word"
        return label
    }()
    
    lazy var wordType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "noun"
        label.font = UIFont.italicSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var definition: UILabel = {
        let definition = UILabel()
        definition.translatesAutoresizingMaskIntoConstraints = false
        definition.lineBreakMode = .byWordWrapping
        definition.numberOfLines = 5
        definition.text = "Press refresh button to generate a new word!"
        definition.numberOfLines = 0
        definition.lineBreakMode = .byTruncatingTail
        return definition
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 40)
        let config = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: "arrow.counterclockwise.circle", withConfiguration: config)?.withTintColor(UIColor(red: 240/255, green: 113/255, blue: 103/255, alpha: 1), renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapRefresh), for: .touchUpInside)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        searchbar.barTintColor = UIConfiguration.backgroundColor
        searchbar.placeholder = "Search for word"
        searchbar.layer.cornerRadius = 25
        searchbar.delegate = self
        return searchbar
    }()
        
    //MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConfiguration.backgroundColor
        addSubViews()
    }
    
    //MARK: - UI Setup
    private func addSubViews() {

        view.addSubview(stackView)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(tableView)
        
        view.addSubview(titleLabel)
        view.addSubview(definitionCard)
        view.addSubview(word)
        view.addSubview(wordType)
        view.addSubview(definition)
        view.addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            definitionCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            definitionCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            definitionCard.heightAnchor.constraint(equalToConstant: 200),
            definitionCard.widthAnchor.constraint(equalToConstant: 350),
            word.topAnchor.constraint(equalTo: definitionCard.topAnchor, constant: 10),
            word.leadingAnchor.constraint(equalTo: definitionCard.leadingAnchor, constant: 10),
            wordType.leadingAnchor.constraint(equalTo: word.trailingAnchor, constant: 5),
            wordType.topAnchor.constraint(equalTo: definitionCard.topAnchor, constant: 15),
            definition.topAnchor.constraint(equalTo: word.bottomAnchor, constant: 10),
            definition.leadingAnchor.constraint(equalTo: definitionCard.leadingAnchor, constant: 5),
            definition.trailingAnchor.constraint(equalTo: definitionCard.trailingAnchor, constant: -5),
            refreshButton.bottomAnchor.constraint(equalTo: definitionCard.bottomAnchor, constant: -10),
            refreshButton.trailingAnchor.constraint(equalTo: definitionCard.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: definitionCard.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            searchBar.topAnchor.constraint(equalTo: definitionCard.bottomAnchor, constant: 10),
//            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func didTapRefresh() {
        
        presentSpinnerView()
        
        NetworkManager.shared.fetchRandomWord { [weak self] result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self?.word.text = result.word
                    self?.definition.text = result.results?.first?.definition
                    self?.wordType.text = result.results?.first?.partOfSpeech
                    self?.removeSpinnerView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func presentSpinnerView() {
        addChild(spinnerView)
        view.addSubview(spinnerView.view)
        spinnerView.view.frame = view.frame
        spinnerView.didMove(toParent: self)
    }
    
    func removeSpinnerView() {
        spinnerView.willMove(toParent: nil)
        spinnerView.view.removeFromSuperview()
        spinnerView.removeFromParent()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordDetails.first?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedWord = wordDetails.first?.word
        
        let selectedDetails = wordDetails.first?.results?[indexPath.row]
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = UIConfiguration.definitionCardBackground
        
        //cell.configure(word: selectedWord)
        cell.wordTitle.text = selectedWord
        cell.partOfSpeech.text = selectedDetails?.partOfSpeech
        cell.definition.text  = selectedDetails?.definition
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedWord = wordDetails.first?.word

        //Have to figure out how to get this to conform to Word model
//        navigationController?.pushViewController(DetailViewController(word: selectedWord, wordDetail: selectedWord, selectedWord: selectedWord.word), animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let userInputedWord = searchBar.text else {
            return
        }
        
        presentSpinnerView()
        
        NetworkManager.shared.fetchWord(word: userInputedWord) { [weak self] result in
            
            switch result {
            case .success(let output):
                self?.wordDetails.insert(output, at: 0)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        removeSpinnerView()
    }
}
