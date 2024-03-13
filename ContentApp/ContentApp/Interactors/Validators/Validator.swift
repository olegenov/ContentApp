//
//  Validator.swift
//  ContentApp
//
//  Created by Никита Китаев on 12.03.2024.
//

import Foundation

protocol Validator {
    func validate(_ formData: SignupFormData) -> (isValid: Bool, errorMessages: [String])
}
