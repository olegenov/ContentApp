//
//  TeamnInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import Foundation

protocol TeamBusinessLogic {
    func loadUsers(id: Int)
}

final class TeamInteractor: TeamBusinessLogic {
    var presenter: TeamPresentationLogic?
    var apiService: APIService
    private var apiUrl: String = "teams/"
    
    init(presenter: TeamPresentationLogic, apiService: APIService) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func loadUsers(id: Int) {
        apiService.fetchData(urlString: apiUrl + String(format: "%d", id), responseType: TeamResponse.self, token: true) { result in
            switch result {
            case .success(let teamResponse):
                self.handleSuccessResponse(teamResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessResponse(_ teamResponse: TeamResponse?) {
        guard let response = teamResponse else {
            return
        }

        let title = response.name
        var users: [User] = []
        var creatorId = 0
        
        for userResponse in response.users {
            var user = User(
                id: userResponse.id,
                username: userResponse.username,
                firstname: userResponse.firstname,
                surname: userResponse.surname,
                email: userResponse.email
            )
            
            if userResponse.id == teamResponse?.creator.id {
                creatorId = userResponse.id
            }
            
            users.append(user)
        }
        
        self.presenter?.displayUsers(title: title, users: users, creatorId: creatorId)
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
    }
}
