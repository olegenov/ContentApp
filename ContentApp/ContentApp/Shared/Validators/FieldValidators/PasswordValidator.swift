//
//  PasswordValidator.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

class PasswordValidator: FieldValidator {    
    enum Constants {
        static let minLength: Int = 6
        
        static let digitsRegex: String = "\\d"
        static let allowedCharactersRegex: String = "^[a-zA-Z0-9_!@#$%^&*()-_+=;:,./?\\|`~\\[\\]{}]+$"
        
        static let passwordLengthError: String = "password is too short"
        static let noDigitsError: String = "password must contain digits"
        static let forbiddenCharactersError: String = "forbidden symbols in password"
        static let passwordRequiredError: String = "password required"
    }
    
    func validate(_ text: String) -> (isValid: Bool, errorMessages: [String]) {
        var errorMessages: [String] = []
        
        if text.isEmpty {
            errorMessages.append(Constants.passwordRequiredError)
        }
        else if text.count < Constants.minLength {
            errorMessages.append(Constants.passwordLengthError)
        }
        
        if text.range(of: Constants.digitsRegex, options: .regularExpression) == nil {
            errorMessages.append(Constants.noDigitsError)
        }
        
        if text.range(of: Constants.allowedCharactersRegex, options: .regularExpression) == nil {
            errorMessages.append(Constants.forbiddenCharactersError)
        }
        
        if errorMessages.isEmpty {
            return (true, [""])
        }
        
        return (false, errorMessages)
    }
}
