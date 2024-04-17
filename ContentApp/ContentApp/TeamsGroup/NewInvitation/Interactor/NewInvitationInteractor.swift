//
//  NewInvitationInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import Foundation

protocol NewInvitationBusinessLogic {
    func submitFormData(_ formData: NewInvitationFormData)
}

final class NewInvitationInteractor: NewInvitationBusinessLogic {
    enum Constants {
        public static var requestError: String = "empty invitation data"
    }
    
    private var presenter: NewInvitationPresentationLogic?
    private var apiService: APIServiceProtocol
    private var tokenManager = TokenManager.shared
    private var invitationsApiUrl: String = "invitations/"
    private var teamsApiUrl: String = "teams/my"
    
    init(presenter: NewInvitationPresentationLogic, apiService: APIServiceProtocol) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func submitFormData(_ formData: NewInvitationFormData) {
        if formData.username.isEmpty {
            self.presenter?.presentError(errors: [Constants.requestError])
            return
        }
        let teamId = formData.teamId
        
        let request = InvitationRequest(team_id: teamId, receiver_username: formData.username)
        createInvitation(request: request)
    }
    
    func createInvitation(request: InvitationRequest) {
        apiService.postData(urlString: invitationsApiUrl, parameters: request, responseType: EmptyResponse.self, token: true) { result in
            switch result {
            case .success(_):
                self.handleSuccessCreationResponse()
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessCreationResponse() {
        self.presenter?.handleSuccessCreation()
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
    }
}
