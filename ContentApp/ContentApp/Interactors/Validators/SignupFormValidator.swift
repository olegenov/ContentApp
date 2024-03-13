//
//  LoginFormValidator.swift
//  ContentApp
//
//  Created by Никита Китаев on 12.03.2024.
//

import Foundation


final class SignupFormValidator : Validator {
    let emailValidator = EmailValidator()
    let passwordValidator = PasswordValidator()
    let usernameValidator = UsernameValidator()
    
    func validate(_ formData: SignupFormData) -> (isValid: Bool, errorMessages: [String]) {
        var errorMessages: [String] = []
        
        var validatedEmail = emailValidator.validate(formData.email)
        
        if !validatedEmail.isValid {
            errorMessages += (validatedEmail.errorMessages)
        }
        
        var validatedPassword = passwordValidator.validate(formData.password)
        
        if !validatedPassword.isValid {
            errorMessages += (validatedPassword.errorMessages)
        }
        
        var validatedUsername = usernameValidator.validate(formData.username)
        
        if !validatedUsername.isValid {
            errorMessages += (validatedUsername.errorMessages)
        }
        
        if errorMessages.isEmpty {
            return (true, [])
        }
        
        return (false, errorMessages)
    }
}
