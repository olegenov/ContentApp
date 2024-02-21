//
//  FormInput.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

final class FormInput: UIView, UITextFieldDelegate {
    enum PlaceholderType {
            case username
            case password
            case email
            case repeatPassword
        }

    enum Constants {
        static var height: CGFloat = 36
        
        static var cornerRadius: CGFloat = 18
        static var borderWidth: CGFloat = 1
        static var borderColor: UIColor = UIColor.AppColors.outlineColor
        
        static var placeHolderColor: UIColor = UIColor.AppColors.outlineColor
        static var placeHolderFontSize: CGFloat = 16
        
        static var paddingHorizontal: CGFloat = 16
        static var paddingVertical: CGFloat = 8
        
        static var usernamePlaceHolder: String = "username"
        static var passwordPlaceHolder: String = "password"
        static var repeatPasswordPlaceHolder: String = "repeat password"
        static var emailPlaceHolder: String = "email"
    }
    
    var input: UITextField = UITextField()

    init(_ type: PlaceholderType) {
        super.init(frame: .zero)
        
        configureUI(for: type)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getData() -> String? {
        return input.text
    }
    
    private func configureUI(for type: PlaceholderType) {
        translatesAutoresizingMaskIntoConstraints = false
        
        input.translatesAutoresizingMaskIntoConstraints = false
        
        input.autocapitalizationType = .none
        input.placeholder = placeholder(for: type)
        input.layer.cornerRadius = Constants.cornerRadius
        input.layer.borderWidth = Constants.borderWidth
        input.layer.borderColor = Constants.borderColor.cgColor
        
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.paddingHorizontal, height: Constants.height))
        input.leftViewMode = .always
        
        
        addSubview(input)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.height),
            
            input.centerXAnchor.constraint(equalTo: centerXAnchor),
            input.heightAnchor.constraint(equalToConstant: Constants.height),
            input.leadingAnchor.constraint(equalTo: leadingAnchor),
            input.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func placeholder(for type: PlaceholderType) -> String {
        switch type {
        case .username:
            return Constants.usernamePlaceHolder
        case .password:
            return Constants.passwordPlaceHolder
        case .email:
            return Constants.emailPlaceHolder
        case .repeatPassword:
            return Constants.repeatPasswordPlaceHolder
        }
    }
}
