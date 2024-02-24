//
//  FormInput.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

final class FormInput: UIView {
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
    var validator: Validator?

    init(_ placeholder: String) {
        super.init(frame: .zero)
        
        configureUI(placeholder: placeholder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getData() -> String? {
        return input.text
    }
    
    private func configureUI(placeholder: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        input.translatesAutoresizingMaskIntoConstraints = false
        input.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.font: UIFont.appFont(.placeholder), NSAttributedString.Key.foregroundColor: UIColor.AppColors.outlineColor])
        input.layer.cornerRadius = Constants.cornerRadius
        input.layer.borderWidth = Constants.borderWidth
        input.layer.borderColor = Constants.borderColor.cgColor
        
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.paddingHorizontal, height: Constants.height))
        input.leftViewMode = .always
        
        input.font = UIFont.appFont(.formInput)
        input.textColor = UIColor.AppColors.textColor

        addSubview(input)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.height),
            
            input.centerXAnchor.constraint(equalTo: centerXAnchor),
            input.heightAnchor.constraint(equalToConstant: Constants.height),
            input.leadingAnchor.constraint(equalTo: leadingAnchor),
            input.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
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
    
    func setValidator(_ validator: Validator?) {
        self.validator = validator
    }
    
    func makeErrorField() {
        input.layer.borderColor = UIColor.AppColors.darkRed.cgColor
    }
    
    func validate() -> (isValid: Bool, errorMessages: [String]) {
        guard let validator = validator else {
            return (true, [""])
        }

        let currentText = input.text ?? ""
        return validator.validate(currentText)
    }
}
