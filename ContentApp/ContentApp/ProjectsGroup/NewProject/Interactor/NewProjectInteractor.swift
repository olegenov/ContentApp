//
//  NewProjectInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import Foundation

protocol NewProjectBusinessLogic {
    func loadTeams()
    
    func submitFormData(_ formData: NewProjectFormData)
}

final class NewProjectInteractor: NewProjectBusinessLogic {
    enum Constants {
        public static var requestError: String = "empty project data"
    }
    
    private var presenter: NewProjectPresentationLogic?
    private var apiService: APIServiceProtocol
    private var tokenManager = TokenManager.shared
    private var projectsApiUrl: String = "projects/"
    private var teamsApiUrl: String = "teams/my"
    private var createTeamApiUrl: String = "teams/"
    
    init(presenter: NewProjectPresentationLogic, apiService: APIServiceProtocol) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func submitFormData(_ formData: NewProjectFormData) {
        if formData.name.isEmpty {
            self.presenter?.presentError(errors: [Constants.requestError])
            return
        }
        var teamId = formData.team.id
        
        if teamId == 0 {
            var request = NewTeamRequest(name: formData.team.name)
            
            createTeamAndProject(teamRequest: request, projectName: formData.name)
            return
        }
        
        let request = NewProjectRequest(name: formData.name, team_id: teamId)
        createProject(request: request)
    }
    
    func createTeamAndProject(teamRequest: NewTeamRequest, projectName: String) {
        apiService.postData(urlString: createTeamApiUrl, parameters: teamRequest, responseType: NewTeamResponse.self, token: true) { result in
            switch result {
            case .success(let newTeamResponse):
                let projectRequest = NewProjectRequest(name: projectName, team_id: newTeamResponse.id)
                
                self.createProject(request: projectRequest)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    func createProject(request: NewProjectRequest) {
        apiService.postData(urlString: projectsApiUrl, parameters: request, responseType: NewProjectResponse.self, token: true) { result in
            switch result {
            case .success(let newProjectResponse):
                self.handleSuccessCreationResponse(newProjectResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    func loadTeams() {
        apiService.fetchData(urlString: teamsApiUrl, responseType: MyTeamsResponse.self, token: true) { result in
            switch result {
            case .success(let myTeamsResponse):
                self.handleSuccessTeamResponse(myTeamsResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessTeamResponse(_ myTeamsResponse: MyTeamsResponse?) {
        var teams: [Team] = []
        
        for teamReponse in myTeamsResponse?.teams ?? [] {
            teams.append(Team(id: teamReponse.id, name: teamReponse.name))
        }
        
        self.presenter?.updateTeams(teams: teams)
    }
    
    private func handleSuccessCreationResponse(_ newProjectResponse: NewProjectResponse?) {
        self.presenter?.handleSuccessCreation()
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
    }
}
