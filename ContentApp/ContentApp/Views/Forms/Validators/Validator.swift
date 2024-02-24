//
//  Validator.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

protocol Validator {
    func validate(_ text: String) -> (isValid: Bool, errorMessages: [String])
}
