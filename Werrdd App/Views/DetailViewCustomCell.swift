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
        stackView.spacing = 20
        stackView.alignment = .leading
        return stackView
    }()
    
    let definitionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let partOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
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
        definitionStackView.addArrangedSubview(partOfSpeechLabel)
        definitionStackView.addArrangedSubview(bodyLabel)
        mainStackView.addArrangedSubview(definitionStackView)
        mainStackView.addArrangedSubview(titleLabel)
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
}
