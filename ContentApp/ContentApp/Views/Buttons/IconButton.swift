//
//  IconButton.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

final class IconButton: Button {
    enum Constants {
        static let backgroundColor: UIColor = UIColor.clear
    }
    
    init(_ type: IconFactory.Types) {
        super.init()
        
        configureUI(IconFactory.createIcon(type: type))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(_ icon: Icon) {
        
        backgroundColor = Constants.backgroundColor
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(icon)
        
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}
