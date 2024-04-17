//
//  NewTeamInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 11.04.2024.
//

import Foundation

protocol NewTeamBusinessLogic {
    func submitFormData(_ formData: NewTeamFormData)
}

final class NewTeamInteractor: NewTeamBusinessLogic {
    enum Constants {
        public static var requestError: String = "empty name data"
    }
    
    private var presenter: NewTeamPresentationLogic?
    private var apiService: APIServiceProtocol
    private var tokenManager = TokenManager.shared
    private var createTeamApiUrl: String = "teams/"
    
    init(presenter: NewTeamPresentationLogic, apiService: APIServiceProtocol) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func submitFormData(_ formData: NewTeamFormData) {
        if formData.name.isEmpty {
            self.presenter?.presentError(errors: [Constants.requestError])
            return
        }
        
        
        let request = NewTeamRequest(name: formData.name)
        createTeam(request: request)
    }
    
    func createTeam(request: NewTeamRequest) {
        apiService.postData(urlString: createTeamApiUrl, parameters: request, responseType: NewTeamResponse.self, token: true) { result in
            switch result {
            case .success(let newTeamResponse):
                self.handleSuccessCreationResponse(newTeamResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessCreationResponse(_ newTeamResponse: NewTeamResponse?) {
        self.presenter?.handleSuccessCreation()
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
    }
}
