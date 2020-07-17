//
//  HeaderView.swift
//  CompLayoutTest
//
//  Created by Admin on 17.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    static let identifier = "HeaderView"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.frame = .zero
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
