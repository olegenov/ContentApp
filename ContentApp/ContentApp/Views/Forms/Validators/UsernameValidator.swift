//
//  LoginValidator.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

class UsernameValidator: Validator {
    enum Constants {
        static let minLength: Int = 3
        
        static let allowedCharactersRegex: String = "^[a-zA-Z0-9_-]+$"
        
        static let passwordLengthError: String = "username is to short"
        static let forbiddenCharactersError: String = "forbidden symbols in username"
    }
    
    func validate(_ text: String) -> (isValid: Bool, errorMessages: [String]) {
        var errorMessages: [String] = []
        
        if text.count < Constants.minLength {
            errorMessages.append(Constants.passwordLengthError)
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
