//
//  NewProjectInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import Foundation

protocol NewProjectBusinessLogic {
    func submitFormData(_ formData: NewProjectFormData)
}

final class NewProjectInteractor: NewProjectBusinessLogic {
    enum Constants {
        public static var requestError: String = "empty project data"
    }
    
    private var presenter: NewProjectPresentationLogic?
    private var apiService: APIServiceProtocol
    private var tokenManager = TokenManager.shared
    private var apiUrl: String = "projects/"
    
    init(presenter: NewProjectPresentationLogic, apiService: APIServiceProtocol) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func submitFormData(_ formData: NewProjectFormData) {
        if formData.name.isEmpty {
            self.presenter?.presentError(errors: [Constants.requestError])
            return
        }
        
        let request = NewProjectRequest(name: formData.name)
        
        apiService.postData(urlString: apiUrl, parameters: request, responseType: NewProjectResponse.self, token: true) { result in
            switch result {
            case .success(let newProjectResponse):
                self.handleSuccessResponse(newProjectResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessResponse(_ newProjectResponse: NewProjectResponse?) {
        self.presenter?.handleSuccessCreation()
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
    }
}
