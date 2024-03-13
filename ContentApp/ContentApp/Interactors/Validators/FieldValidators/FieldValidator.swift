//
//  Validator.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

protocol FieldValidator {
    associatedtype FieldType
    func validate(_ value: FieldType) -> (isValid: Bool, errorMessages: [String])
}
