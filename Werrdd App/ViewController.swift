//
//  ViewController.swift
//  Werrdd App
//
//  Created by Kevin Phan on 3/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    var words = [Word]()
    let spinnerView = SpinnerViewController()

    
//    let words: [tempWordModel] = [
//        tempWordModel(word: "alleviate", definition: ": to make (something, such as pain or suffering) more bearable", partOfSpeech: "verb"),
//        tempWordModel(word: "slosh", definition: ": to flounder or splash through water, mud, or slush", partOfSpeech: "noun"),
//        tempWordModel(word: "oligarchy", definition: ": a government in which a small group exercises control especially for corrupt and selfish purposes", partOfSpeech: "noun"),
//        tempWordModel(word: "stint", definition: ": a period of time spent at a particular activity", partOfSpeech: "noun"),
//        tempWordModel(word: "ETA", definition: ": estimated time of arrival", partOfSpeech: "abbreviation"),
//        tempWordModel(word: "culture", definition: ": the customary beliefs, social forms, and material traits of a racial, religious, or social group", partOfSpeech: "noun"),
//        tempWordModel(word: "accountability", definition: ": the quality or state of being accountable", partOfSpeech: "noun"),
//        tempWordModel(word: "waka", definition: ": a Japanese poem consisting of 31 syllables in 5 lines, with 5 syllables in the first and third lines and 7 in the others", partOfSpeech: "noun"),
//        tempWordModel(word: "verdurous", definition: ": rich in verdure; freshly green; verdant", partOfSpeech: "adjective"),
//        tempWordModel(word: "felicitous", definition: ": well-suited for the occasion, as an action, manner, or expression; apt; appropriate", partOfSpeech: "adjective"),
//        tempWordModel(word: "transcendental", definition: ": abstract or metaphysical", partOfSpeech: "adjective")
//    ]
    
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
        tableView.delegate = self
        tableView.dataSource = self
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
        //view.addSubview(tableView)
        //view.addSubview(spinner)
        //view.addSubview(searchBar)

        
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
        //let child = SpinnerViewController()
        spinnerView.willMove(toParent: nil)
        spinnerView.view.removeFromSuperview()
        spinnerView.removeFromParent()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
//        cell.word.text = words[indexPath.row].word
//        cell.partOfSpeech.text = words[indexPath.row].results
//        cell.definition.text = words[indexPath.row].definition
        
        cell.backgroundColor = UIConfiguration.definitionCardBackground
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedWord = words[indexPath.row]
        
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
        
        NetworkManager.shared.fetchWord(word: userInputedWord) { [weak self] result in
            print(result)
        }
    }
}
