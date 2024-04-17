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
        
        setTitle(title, for: .normal)
        configureUI()
    }
    
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        layer.cornerRadius = Constants.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        
        addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
        addTarget(self, action: #selector(buttonTouchUp), for: .touchCancel)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.height),
        ])
    }
    
    func addPadding() {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: Constants.paddingVertical,
                                                           leading: Constants.paddingHorizontal,
                                                           bottom: Constants.paddingVertical,
                                                           trailing: Constants.paddingHorizontal)
        self.configuration = configuration
    }
    
    @objc func buttonTouchDown() {
    }
    
    @objc func buttonTouchUp() {
    }
    
    func makeActive() {
        backgroundColor = ButtonActive.Constants.backgroundColor
        setTitleColor(ButtonActive.Constants.titleColor, for: .normal)
        layer.borderWidth = 0
    }
    
    func makeRegular() {
        backgroundColor = ButtonRegular.Constants.backgroundColor
        titleLabel?.textColor = ButtonRegular.Constants.titleColor
        layer.borderColor = ButtonRegular.Constants.borderColor.cgColor
        layer.borderWidth = 1
    }
}
