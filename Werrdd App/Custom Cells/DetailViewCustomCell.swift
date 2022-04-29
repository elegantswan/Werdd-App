//
//  DetailViewCustomCell.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/14/22.
//

import UIKit

class DetailViewCustomCell: UIView {
    
    //MARK: - UIElements
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Yeeeet"
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans-Bold", size: 14)
        label.text = "Property not avaialble"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let partOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GillSans-Bold", size: 12)
        return label
    }()
    
    //MARK: - Property Observers
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var body: String? {
        didSet {
            bodyLabel.text = body
        }
    }
    
    var partOfSpeech: String? {
        didSet {
            partOfSpeechLabel.text = partOfSpeech
        }
    }
    
    //MARK: - Initializer
    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        partOfSpeechLabel.isHidden = true
        layer.cornerRadius = 20
        setupDefinitionStackView()
        setupStackView()
    }
    
    private func setupDefinitionStackView() {
        mainStackView.addArrangedSubview(bodyLabel)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(partOfSpeechLabel)
    }
    
    private func addTitleLabel() {
        
    }
    
    private func setupStackView() {
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func showPartOfSpeech() {
        partOfSpeechLabel.isHidden = false
    }
}
