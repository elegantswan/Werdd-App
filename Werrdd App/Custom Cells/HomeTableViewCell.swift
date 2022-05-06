//
//  CustomTableViewCell.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/4/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
        
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    // MARK: - UI Properties
    lazy var wordTitle: UILabel = {
        let word = UILabel()
        word.translatesAutoresizingMaskIntoConstraints = false
        word.font = .boldSystemFont(ofSize: 20)
        return word
    }()
    
    lazy var partOfSpeech: UILabel = {
        let partOfSpeech = UILabel()
        partOfSpeech.translatesAutoresizingMaskIntoConstraints = false
        partOfSpeech.font = .italicSystemFont(ofSize: 14)
        return partOfSpeech
    }()
    
    lazy var definition: UILabel = {
        let definition = UILabel()
        definition.translatesAutoresizingMaskIntoConstraints = false
        definition.numberOfLines = 0
        definition.lineBreakMode = .byWordWrapping
        return definition
    }()
    
    private func setupUI() {
        contentView.addSubview(wordTitle)
        contentView.addSubview(partOfSpeech)
        contentView.addSubview(definition)
        
        NSLayoutConstraint.activate([
            wordTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            wordTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            wordTitle.bottomAnchor.constraint(equalTo: definition.topAnchor),
            
            partOfSpeech.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            partOfSpeech.bottomAnchor.constraint(equalTo: definition.topAnchor),
            partOfSpeech.leadingAnchor.constraint(equalTo: wordTitle.trailingAnchor, constant: 5),
            
            definition.topAnchor.constraint(equalTo: wordTitle.bottomAnchor, constant: 10),
            definition.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            definition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            definition.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
