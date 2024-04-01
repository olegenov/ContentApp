//
//  ProjectsPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

protocol ProjectsPresentationLogic {
    func displayProjects(projects: [Project])
    func presentError(errors: [String])
}

class ProjectsPresenter: ProjectsPresentationLogic {
    var viewController: ProjectsDisplayLogic?
    
    func displayProjects(projects: [Project]) {
        viewController?.displayProjects(projects)
    }
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
}
