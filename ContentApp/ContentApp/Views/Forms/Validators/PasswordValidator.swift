//
//  PasswordValidator.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

class PasswordValidator: Validator {    
    enum Constants {
        static let minLength: Int = 6
        
        static let digitsRegex: String = "\\d"
        static let allowedCharactersRegex: String = "^[a-zA-Z0-9_!@#$%^&*()-_+=;:,./?\\|`~\\[\\]{}]+$"
        
        static let passwordLengthError: String = "password is to short"
        static let noDigitsError: String = "password must contain digits"
        static let forbiddenCharactersError: String = "forbidden symbols in password"
    }
    
    func validate(_ text: String) -> (isValid: Bool, errorMessages: [String]) {
        var errorMessages: [String] = []
        
        if text.count < Constants.minLength {
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
