//
//  LoginFormInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

protocol LoginBusinessLogic {
    func submitFormData(_ formData: LoginFormData)
}

final class LoginFormInteractor: LoginBusinessLogic {
    enum Constants {
        public static var loginError: String = "invalid username or password"
        public static var tokenError: String = "auth error"
        public static var requestError: String = "empty login data"
    }
    
    private var presenter: LoginPresentationLogic?
    private var apiService: APIServiceProtocol
    private var tokenManager: TokenManager
    private var apiUrl: String = "auth/login"
    
    init(presenter: LoginPresentationLogic, apiService: APIServiceProtocol, tokenManager: TokenManager) {
        self.presenter = presenter
        self.apiService = apiService
        self.tokenManager = tokenManager
    }
    
    func submitFormData(_ formData: LoginFormData) {
        if formData.username.isEmpty || formData.password.isEmpty {
            self.presenter?.presentError(errors: [Constants.requestError])
            return
        }
        
        let request = LoginRequest(username: formData.username, password: formData.password)
        apiService.postData(url: apiUrl, parameters: request.toDict(), completion: handleResponse)
    }
    
    func handleResponse(response: Result<Data, ApiError>) {
        switch response {
        case .success(let data):
            let token = self.apiService.extractToken(from: data)
            
            if (token == nil) {
                self.presenter?.presentError(errors: [Constants.tokenError])
            }
            
            self.tokenManager.saveToken(token: token!)
            self.presenter?.handleSuccessLogin()
        case .failure(let error):
            self.presenter?.presentError(errors: [error.message])
        }
    }
}
