//
//  ProjectsInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

protocol ProjectsBusinessLogic {
    func loadProjects()
}

final class ProjectsInteractor: ProjectsBusinessLogic {
    var presenter: ProjectsPresentationLogic?
    var apiService: APIService
    private var apiUrl: String = "projects/my"
    
    init(presenter: ProjectsPresentationLogic, apiService: APIService) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func loadProjects() {
        apiService.fetchData(urlString: apiUrl, responseType: MyProjectsResponse.self, token: true) { result in
            switch result {
            case .success(let myProjectsResponse):
                self.handleSuccessResponse(myProjectsResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessResponse(_ myProjectsResponse: MyProjectsResponse?) {
        if (myProjectsResponse == nil) {
            return
        }
        
        var projects: [Project] = []
        
        for project in myProjectsResponse!.projects {
            projects.append(Project(id: project.id, name: project.name))
        }
        
        self.presenter?.handleSuccess(projects: projects)
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
    }
}
