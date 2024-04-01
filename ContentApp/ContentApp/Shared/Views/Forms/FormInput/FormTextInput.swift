//
//  FormTextInput.swift
//  ContentApp
//
//  Created by Никита Китаев on 27.03.2024.
//

import UIKit

class FormTextInput: UIView, FormInput {
    
    enum Constants {
        static var height: CGFloat = 36
        
        static var cornerRadius: CGFloat = 18
        static var borderWidth: CGFloat = 1
        static var borderColor: UIColor = UIColor.AppColors.outlineColor
        
        static var placeHolderColor: UIColor = UIColor.AppColors.outlineColor
        static var placeHolderFontSize: CGFloat = 16
        
        static var paddingHorizontal: CGFloat = 16
        static var paddingVertical: CGFloat = 8
    }
    
    var input: UITextField = UITextField()

    init(_ placeholder: String) {
        super.init(frame: .zero)
        
        configureUI(placeholder: placeholder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getData() -> String {
        return input.text ?? ""
    }
    
    private func configureUI(placeholder: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        input.translatesAutoresizingMaskIntoConstraints = false
        
        configurePlaceholder(placeholder)
        configureContainer()
        configureBorder()
        configureInputFont()

        addSubview(input)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.height),
            
            input.centerXAnchor.constraint(equalTo: centerXAnchor),
            input.heightAnchor.constraint(equalToConstant: Constants.height),
            input.leadingAnchor.constraint(equalTo: leadingAnchor),
            input.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func configureBorder() {
        input.layer.cornerRadius = Constants.cornerRadius
        input.layer.borderWidth = Constants.borderWidth
        input.layer.borderColor = Constants.borderColor.cgColor
    }
    
    private func configurePlaceholder(_ placeholder: String) {
        input.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.font: UIFont.appFont(.placeholder), NSAttributedString.Key.foregroundColor: UIColor.AppColors.outlineColor])
    }
    
    private func configureContainer() {
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.paddingHorizontal, height: Constants.height))
        input.leftViewMode = .always
    }
    
    private func configureInputFont() {
        input.font = UIFont.appFont(.formInput)
        input.textColor = UIColor.AppColors.textColor
    }
    
    public func disableAutoCorrection() {
        input.autocapitalizationType = .none
        input.autocorrectionType = .no
    }
    
    public func enableSecuring() {
        input.isSecureTextEntry = true
    }
    
    public func setKeyBoardType(_ type: UIKeyboardType) {
        input.keyboardType = type
    }
    
    func makeErrorField() {
        input.layer.borderColor = UIColor.AppColors.darkRed.cgColor
    }
}
