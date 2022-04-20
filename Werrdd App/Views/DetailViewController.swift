//
//  DetailViewController.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/12/22.
//

import UIKit

class DetailViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConfiguration.backgroundColor
        setupUI()
    }
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = title
    }
    
    //MARK: - UI Elements
    lazy var definitionCard : UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 25
        card.backgroundColor = UIConfiguration.definitionCardBackground
        return card
    }()

    lazy var synonymsCard : UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 25
        card.backgroundColor = UIConfiguration.definitionCardBackground
        return card
    }()

    lazy var antonymsCard : UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 25
        card.backgroundColor = UIConfiguration.definitionCardBackground
        return card
    }()

    lazy var exampleCard : UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 25
        card.backgroundColor = UIConfiguration.definitionCardBackground
        return card
    }()
    
//    let definitionCard = DetailViewCustomCell(title: "definition", body: "hello 123")
//
//    let synonymsCard = DetailViewCustomCell(title: "definition", body: "hello 123")
//
//    let antonymsCard = DetailViewCustomCell(title: "definition", body: "hello 123")
//
//    let exampleCard = DetailViewCustomCell(title: "definition", body: "hello 123")
    
    private func setupUI() {
        
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
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
