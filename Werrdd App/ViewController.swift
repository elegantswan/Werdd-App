//
//  ViewController.swift
//  Werrdd App
//
//  Created by Kevin Phan on 3/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    struct wordModel {
        let word: String
        let definition: String
        let partOfSpeech: String
    }
    
    let words: [wordModel] = [
        wordModel(word: "alleviate", definition: ": to make (something, such as pain or suffering) more bearable", partOfSpeech: "verb"),
        wordModel(word: "slosh", definition: ": to flounder or splash through water, mud, or slush", partOfSpeech: "noun"),
        wordModel(word: "oligarchy", definition: ": a government in which a small group exercises control especially for corrupt and selfish purposes", partOfSpeech: "noun"),
        wordModel(word: "stint", definition: ": a period of time spent at a particular activity", partOfSpeech: "noun"),
        wordModel(word: "ETA", definition: ": estimated time of arrival", partOfSpeech: "abbreviation"),
        wordModel(word: "culture", definition: ": the customary beliefs, social forms, and material traits of a racial, religious, or social group", partOfSpeech: "noun"),
        wordModel(word: "accountability", definition: ": the quality or state of being accountable", partOfSpeech: "noun"),
        wordModel(word: "waka", definition: ": a Japanese poem consisting of 31 syllables in 5 lines, with 5 syllables in the first and third lines and 7 in the others", partOfSpeech: "noun"),
        wordModel(word: "verdurous", definition: ": rich in verdure; freshly green; verdant", partOfSpeech: "adjective"),
        wordModel(word: "felicitous", definition: ": well-suited for the occasion, as an action, manner, or expression; apt; appropriate", partOfSpeech: "adjective"),
        wordModel(word: "transcendental", definition: ": abstract or metaphysical", partOfSpeech: "adjective")
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConfiguration.backgroundColor
        addSubViews()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(definitionCard)
        view.addSubview(word)
        view.addSubview(wordType)
        view.addSubview(definition)
        view.addSubview(refreshButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
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
            tableView.topAnchor.constraint(equalTo: definitionCard.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 25
        tableView.allowsSelection = true
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
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
        label.text = "Michael Jordan"
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
        definition.text = "🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐🐐"
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
    
    @objc private func didTapRefresh() {
        guard let randomWord = randomize() else { return }
        updateCardView(newWord: randomWord)
    }
    
    func randomize() -> wordModel? {
        return words.randomElement()
    }
    
    func updateCardView(newWord word: wordModel) {
        self.word.text = word.word
        self.definition.text = word.definition
        self.wordType.text = word.partOfSpeech
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.word.text = words[indexPath.row].word
        cell.partOfSpeech.text = words[indexPath.row].partOfSpeech
        cell.definition.text = words[indexPath.row].definition
        
        cell.backgroundColor = UIConfiguration.definitionCardBackground
 
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
