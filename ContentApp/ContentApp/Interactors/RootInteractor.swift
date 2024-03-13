//
//  RootInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

protocol RootBusinessLogic {
    func checkToken()
}

final class RootInteractor: RootBusinessLogic {
    var presenter: RootPresentationLogic?
    
    private var apiService: APIServiceProtocol
    private var tokenManager = TokenManager.shared
    private var apiUrl: String = "users/me"
    
    init(presenter: RootPresentationLogic, apiService: APIServiceProtocol) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func checkToken() {
        apiService.fetchData(urlString: apiUrl, responseType: MeResponse.self) { result in
            switch result {
            case .success(let meResponse):
                self.handleSuccessResponse(meResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessResponse(_ tokenResponse: MeResponse?) {
        self.presenter?.handleSuccessLogin()
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
        self.presenter?.switchToSignup()
    }
}
