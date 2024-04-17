//
//  TeamsInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import Foundation

protocol TeamsBusinessLogic {
    func loadTeams()
    func loadInvitations()
}

final class TeamsInteractor: TeamsBusinessLogic {
    var presenter: TeamsPresentationLogic?
    var apiService: APIService
    private var apiUrl: String = "teams/my"
    private var invitationsApiUrl: String = "invitations/my"
    
    init(presenter: TeamsPresentationLogic, apiService: APIService) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func loadTeams() {
        apiService.fetchData(urlString: apiUrl, responseType: MyTeamsResponse.self, token: true) { result in
            switch result {
            case .success(let myTeamsResponse):
                self.handleSuccessResponse(myTeamsResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    func loadInvitations() {
        apiService.fetchData(urlString: invitationsApiUrl, responseType: MyInvitationsResponse.self, token: true) { result in
            switch result {
            case .success(let myInvitationsResponse):
                self.handleSuccessInvitationsResponse(myInvitationsResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessResponse(_ myTeamsResponse: MyTeamsResponse?) {
        if (myTeamsResponse == nil) {
            return
        }
        
        var teams: [TeamCard] = []
        
        for teamReponse in myTeamsResponse!.teams {
            let team = TeamCard(id: teamReponse.id, name: teamReponse.name, creatorId: teamReponse.creator.id, isCreator: teamReponse.creator.id == myTeamsResponse?.request_id)
            teams.append(team)
        }
        
        self.presenter?.displayTeams(teams: teams)
    }
    
    private func handleSuccessInvitationsResponse(_ myInvitationsResponse: MyInvitationsResponse?) {
        if (myInvitationsResponse == nil) {
            return
        }
        
        guard let invitationAmount = myInvitationsResponse?.amount else {
            return
        }
        
        self.presenter?.displayInvitationsAmount(amount: invitationAmount)
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
    }
}
