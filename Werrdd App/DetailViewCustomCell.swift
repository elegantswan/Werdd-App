//
//  DetailViewCustomCell.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/14/22.
//

import UIKit

class DetailViewCustomCell: UIView {
    
    init(title: String, body: String) {
        
        super.init(frame: .zero)
        
        self.title.text = title
        self.body.text = body
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIElements
//    lazy var definitionCard : UIView = {
//        let card = UIView()
//        card.translatesAutoresizingMaskIntoConstraints = false
//        card.layer.cornerRadius = 25
//        card.backgroundColor = UIConfiguration.definitionCardBackground
//        return card
//    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var body: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupUI() {
        
        addSubview(title)
        addSubview(body)
        
        NSLayoutConstraint.activate([
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            body.leadingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            body.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
