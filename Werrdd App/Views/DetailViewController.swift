//
//  DetailViewController.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/12/22.
//

import UIKit

class DetailViewController: UIViewController {
   
    //MARK: - Properties
    let word: Word
    let wordDetails: Result
    let selectedWord: String
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConfiguration.backgroundColor
        setupUI()
    }
    
    //MARK: - Initializer
    init(word: Word, wordDetails: Result ,selectedWord: String) {
        self.word = word
        self.wordDetails = wordDetails
        self.selectedWord = selectedWord
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Elements
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var definitionCard : DetailViewCustomCell = {
        let card = DetailViewCustomCell(backgroundColor: UIConfiguration.definitionCardBackground)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.title = "Definition"
        card.partOfSpeech = wordDetails.partOfSpeech
        return card
    }()

    lazy var synonymsCard : DetailViewCustomCell = {
        let card = DetailViewCustomCell(backgroundColor: UIConfiguration.definitionCardBackground)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.title = "Synonyms"
        card.body = wordDetails.synonyms.joined(separator: ", ")
        return card
    }()

    lazy var antonymsCard : DetailViewCustomCell = {
        let card = DetailViewCustomCell(backgroundColor: UIConfiguration.definitionCardBackground)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.title = "Antonyms"
        card.body = wordDetails.synonyms.joined(separator: ", ")
        return card
    }()

    lazy var exampleCard : DetailViewCustomCell = {
        let card = DetailViewCustomCell(backgroundColor: UIConfiguration.definitionCardBackground)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.title = "Examples"
        card.body = wordDetails.synonyms.joined(separator: ", ")
        return card
    }()
    
    //MARK: - UI Setup
    private func setupUI() {
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(definitionCard)
        stackView.addArrangedSubview(synonymsCard)
        stackView.addArrangedSubview(antonymsCard)
        stackView.addArrangedSubview(exampleCard)
        
        
        view.addSubview(definitionCard)
        view.addSubview(synonymsCard)
        view.addSubview(antonymsCard)
        view.addSubview(exampleCard)
                
        NSLayoutConstraint.activate([
            
            definitionCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            definitionCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            definitionCard.heightAnchor.constraint(equalToConstant: 150),
            definitionCard.widthAnchor.constraint(equalToConstant: 350),
            
            synonymsCard.topAnchor.constraint(equalTo: definitionCard.bottomAnchor, constant: 10),
            synonymsCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            synonymsCard.heightAnchor.constraint(equalToConstant: 150),
            synonymsCard.widthAnchor.constraint(equalToConstant: 350),
            
            antonymsCard.topAnchor.constraint(equalTo: synonymsCard.bottomAnchor, constant: 10),
            antonymsCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            antonymsCard.heightAnchor.constraint(equalToConstant: 150),
            antonymsCard.widthAnchor.constraint(equalToConstant: 350),
            
            exampleCard.topAnchor.constraint(equalTo: antonymsCard.bottomAnchor, constant: 10),
            exampleCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exampleCard.heightAnchor.constraint(equalToConstant: 150),
            exampleCard.widthAnchor.constraint(equalToConstant: 350),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
