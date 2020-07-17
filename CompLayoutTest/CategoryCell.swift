//
//  CategoryCell.swift
//  CompLayoutTest
//
//  Created by Admin on 17.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.frame = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBackground
        label.textColor = .black
        label.text = "Категория"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
