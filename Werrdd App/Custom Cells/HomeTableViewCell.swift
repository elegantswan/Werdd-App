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
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Menlo-Bold", size: 20)
        return label
    }()
    
    lazy var partOfSpeech: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var definition: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Menlo", size: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
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
