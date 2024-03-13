//
//  LoginInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 12.03.2024.
//

import Foundation

protocol SignupBusinessLogic {
    func validateFormData(_ formData: SignupFormData)
    func submitFormData(_ formData: SignupFormData)
}

final class SignupFormInteractor: SignupBusinessLogic {
    var presenter: SignupPresentationLogic?
    var dataValidator: Validator = SignupFormValidator()
    var apiService: APIServiceProtocol = APIService()
    
    init(presenter: SignupPresentationLogic) {
        self.presenter = presenter
    }
    
    func validateFormData(_ formData: SignupFormData) {
        let validated = dataValidator.validate(formData)
 
        if !validated.isValid {
            presenter?.presentValidationError(errors: validated.errorMessages)
        } else {
            submitFormData(formData)
        }
    }
    
    func submitFormData(_ formData: SignupFormData) {
        
    }
}
