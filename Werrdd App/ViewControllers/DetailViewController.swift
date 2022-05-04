//
//  DetailViewController.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/12/22.
//

import UIKit

class DetailViewController: UIViewController {
   
    //MARK: - Properties
    let wordDetails: WordDetail
//    let selectedWord: String
    let selectedWord: Word

    //Experiment
    
    var delegate: FavoritesDelegate?
    
    //MARK: - Action Functions
    
    @objc private func didTapFavoriteButton() {
    
        //delegate?.addToFavorites(favoritedWord: selectedWord)
        
        guard let definition = wordDetails.definition else {
            return
        }
        
        
        DataManager.saveWord(word: selectedWord.word, definition: definition, partOfSpeech: wordDetails.partOfSpeech, synonyms: wordDetails.synonyms, antonyms: wordDetails.antonyms, examples: wordDetails.examples)
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConfiguration.backgroundColor
        setupUI()
    }
    
    //MARK: - Initializer
    init(wordDetails: WordDetail ,selectedWord: Word) {
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
    
    let favoriteButton: UIButton = {
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        let heartImage = UIImage(systemName: "heart", withConfiguration: buttonConfig)
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(heartImage, for: .normal)
        button.tintColor = UIConfiguration.definitionCardBackground
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    lazy var definitionCard : DetailViewCustomCell = {
        let card = DetailViewCustomCell(backgroundColor: UIConfiguration.definitionCardBackground)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.title = "Definition"
        card.showPartOfSpeech()
        card.partOfSpeech = wordDetails.partOfSpeech
        card.bodyLabel.text = wordDetails.definition
        return card
    }()

    lazy var synonymsCard : DetailViewCustomCell = {
        let card = DetailViewCustomCell(backgroundColor: UIConfiguration.definitionCardBackground)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.title = "Synonyms"
        if wordDetails.synonyms == nil {
            card.body = "Can't seem to find any synonyms😔"
        } else {
            card.body = wordDetails.synonyms?.joined(separator: ", ")
        }
        return card
    }()

    lazy var antonymsCard : DetailViewCustomCell = {
        let card = DetailViewCustomCell(backgroundColor: UIConfiguration.definitionCardBackground)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.title = "Antonyms"
        if wordDetails.antonyms == nil {
            card.body = "Can't seem to find any antonyms😔"
        } else {
            card.body = wordDetails.antonyms?.joined(separator: ", ")
        }
        return card
    }()

    lazy var exampleCard : DetailViewCustomCell = {
        let card = DetailViewCustomCell(backgroundColor: UIConfiguration.definitionCardBackground)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.title = "Examples"
        if wordDetails.examples == nil {
            card.body = "Can't seem to find any examples😔"
        } else {
            card.body = wordDetails.examples?.joined(separator: ", ")
        }
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
        view.addSubview(favoriteButton)

                
        NSLayoutConstraint.activate([
            
            favoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            definitionCard.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 30),
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
