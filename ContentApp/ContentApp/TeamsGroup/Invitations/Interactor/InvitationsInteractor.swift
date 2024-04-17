//
//  InvitationsInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.04.2024.
//

import Foundation

protocol InvitationsBusinessLogic {
    func loadInvitations()
    func acceptInvitation(_ id: Int)
    func rejectInvitation(_ id: Int)
}

final class InvitationsInteractor: InvitationsBusinessLogic {
    var presenter: InvitationsPresentationLogic?
    var apiService: APIService
    private var apiUrl: String = "invitations/"

    func acceptInvitation(_ id: Int) {
        apiService.postData(urlString: apiUrl + "\(id)", parameters: EmptyRequest(), responseType: AcceptInvitationResponse.self, token: true) { result in
            switch result {
            case .success(_):
                self.loadInvitations()
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }

    func rejectInvitation(_ id: Int) {
        apiService.deleteData(urlString: apiUrl + "\(id)", responseType: AcceptInvitationResponse.self, token: true) { result in
            switch result {
            case .success(_):
                self.loadInvitations()
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    init(presenter: InvitationsPresentationLogic, apiService: APIService) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func loadInvitations() {
        apiService.fetchData(urlString: apiUrl + "my", responseType: MyInvitationsResponse.self, token: true) { result in
            switch result {
            case .success(let myInvitationsResponse):
                self.handleSuccessResponse(myInvitationsResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessResponse(_ myInvitationsResponse: MyInvitationsResponse?) {
        if (myInvitationsResponse == nil) {
            return
        }
        
        var invitations: [Invitation] = []
        
        for invitationReponse in myInvitationsResponse!.invitations {
            let invitation = Invitation(id: invitationReponse.id, senderUsername: invitationReponse.sender, teamName: invitationReponse.name)
            invitations.append(invitation)
        }
        
        self.presenter?.displayInvitations(invitations: invitations)
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
    }
}
