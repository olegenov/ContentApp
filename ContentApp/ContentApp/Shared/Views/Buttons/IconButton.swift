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
    
    private var iconView: Icon
    
    init(_ type: IconFactory.Types) {
        iconView = IconFactory.createIcon(type: type)
        
        super.init()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}
