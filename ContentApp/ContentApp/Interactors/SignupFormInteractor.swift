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
    enum Constants {
        public static var passwordError: String = "password mismatch"
        public static var authError: String = "auth error"
        public static var requestError: String = "empty signup data"
        public static var userExistsError: String = "such username exists"
    }
    
    private var presenter: SignupPresentationLogic?
    private var dataValidator: Validator = SignupFormValidator()
    private var apiService: APIServiceProtocol
    private var apiUrl: String = "auth/register"
    
    init(presenter: SignupPresentationLogic, apiService: APIServiceProtocol) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func validateFormData(_ formData: SignupFormData) {
        let validated = dataValidator.validate(formData)
 
        if !validated.isValid {
            presenter?.presentError(errors: validated.errorMessages)
        } else {
            submitFormData(formData)
        }
    }
    
    func submitFormData(_ formData: SignupFormData) {
        if formData.username.isEmpty || formData.password.isEmpty {
            self.presenter?.presentError(errors: [Constants.requestError])
            return
        }
        
        if formData.password != formData.repeatPassword {
            self.presenter?.presentError(errors: [Constants.passwordError])
            return
        }
        
        let request = SignupRequest(
            username: formData.username,
            password: formData.password,
            firstname: formData.firstname,
            surname: formData.surname,
            email: formData.email
        )
        
        apiService.postData(url: apiUrl, parameters: request.toDict(), completion: handleResponse)
    }
    
    func handleResponse(response: Result<Data, ApiError>) {
        switch response {
        case .success(_):
            self.presenter?.handleSuccessSignup()
        case .failure(let error):
            self.presenter?.presentError(errors: [error.message])
        }
    }
}
