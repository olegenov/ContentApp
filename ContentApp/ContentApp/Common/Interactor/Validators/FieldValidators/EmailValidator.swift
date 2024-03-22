//
//  EmailValidator.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

class EmailValidator: FieldValidator {
    enum Constants {
        static let emailInputError: String = "invalid email"
        static let emailInputRequiredError: String = "email required"
        static let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        static let format: String = "SELF MATCHES %@"
    }
    
    func validate(_ text: String) -> (isValid: Bool, errorMessages: [String]) {
        var errorMessages: [String] = []
        
        if text.isEmpty {
            errorMessages.append(Constants.emailInputRequiredError)
        }
        
        let emailRegex = Constants.emailRegex
        let emailPredicate = NSPredicate(format: Constants.format, emailRegex)
        
        if !emailPredicate.evaluate(with: text)  {
            errorMessages.append(Constants.emailInputError)
        }
        
        if errorMessages.isEmpty {
            return (true, [])
        }
        
        return (false, errorMessages)
    }
}
