//
//  Button.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

class Button: UIButton {
    enum Constants {
        static var height: CGFloat = 36
        static var cornerRadius: CGFloat = 18
        static var paddingHorizontal: CGFloat = 16
        static var paddingVertical: CGFloat = 8
    }

    init(_ title: String) {
        super.init(frame: .zero)
        
        configureUI(title)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI(_ title: String) {
        setTitle(title, for: .normal)
        layer.cornerRadius = Constants.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        
        titleEdgeInsets.left = Constants.paddingHorizontal
        titleEdgeInsets.right = Constants.paddingHorizontal
        titleEdgeInsets.bottom = Constants.paddingVertical
        titleEdgeInsets.top = Constants.paddingVertical

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.height),
            widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
}
