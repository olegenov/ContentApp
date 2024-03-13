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
    private var tokenManager = TokenManager.shared
    private var apiUrl: String = "auth/login"
    
    init(presenter: LoginPresentationLogic, apiService: APIServiceProtocol) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func submitFormData(_ formData: LoginFormData) {
        if formData.username.isEmpty || formData.password.isEmpty {
            self.presenter?.presentError(errors: [Constants.requestError])
            return
        }
        
        let request = LoginRequest(username: formData.username, password: formData.password)
        
        apiService.postData(urlString: apiUrl, parameters: request, responseType: TokenResponse.self) { result in
            switch result {
            case .success(let tokenResponse):
                self.handleSuccessResponse(tokenResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessResponse(_ tokenResponse: TokenResponse?) {
        let token = tokenResponse?.token
        
        if (token == nil) {
            self.presenter?.presentError(errors: [Constants.tokenError])
        }
        
        self.tokenManager.saveToken(token: token!)
        self.presenter?.handleSuccessLogin()
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
    }
}
