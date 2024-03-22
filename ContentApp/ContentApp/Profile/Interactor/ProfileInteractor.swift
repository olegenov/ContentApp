//
//  ProfileInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import Foundation

protocol ProfileBusinessLogic {
    func loadUser()
    func processLogout()
}

class ProfileInteractor: ProfileBusinessLogic {
    var presenter: ProfilePresentationLogic?
    var apiService: APIService
    
    private var apiUrl = "users/me"
    
    init(presenter: ProfilePresentationLogic, apiService: APIService) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func loadUser() {
        apiService.fetchData(urlString: apiUrl, responseType: MeResponse.self, token: true) { result in
            switch result {
            case .success(let meResponse):
                self.handleSuccessResponse(meResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessResponse(_ meResponse: MeResponse) {
        self.presenter?.updateUserInfo(response: meResponse.data)
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
        self.presenter?.switchToSignup()
    }
    
    internal func processLogout() {
        TokenManager.shared.deleteToken()
        self.presenter?.switchToSignup()
    }
}
