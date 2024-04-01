//
//  Nav.swift
//  ContentApp
//
//  Created by Никита Китаев on 25.03.2024.
//

import UIKit

class Nav: UINavigationBar {
    enum Constants {
        static let nameLabelText: String = "content"
        static let navHeight: CGFloat = 35
    }
    
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureUI() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.navHeight)
        ])
    }
    
    internal func configureNameLabel() {
        let nameLabel = UILabel()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = Constants.nameLabelText
        
        nameLabel.font = UIFont.appFont(.nameLabel)
        
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    internal func configureLeftButton(button: Button) {
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    internal func configureRightButton(button: Button) {
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
