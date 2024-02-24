//
//  Error.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

final class ErrorLabel: UIView {
    enum Constants {
        static var height: CGFloat = 36
        
        static var cornerRadius: CGFloat = 9
        
        static var paddingHorizontal: CGFloat = 16
        static var paddingVertical: CGFloat = 8
    }
    
    private var text: UILabel = UILabel()

    init(_ labelText: String) {
        super.init(frame: .zero)
        
        configureUI(labelText: labelText)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(labelText: String) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = UIColor.AppColors.red
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.appFont(.inputError)
        text.textColor = UIColor.AppColors.darkRed
        text.text = labelText

        addSubview(text)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.height),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingHorizontal),
            text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.paddingHorizontal),
            text.topAnchor.constraint(equalTo: topAnchor, constant: Constants.paddingVertical),
            text.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.paddingVertical),
        ])
    }
    
    public func show() {
        self.alpha = 0.0
        
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1.0
        }
    }
}

