//
//  ProjectsInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

protocol ProjectsBusinessLogic {
}

final class ProjectsInteractor: ProjectsBusinessLogic {
    var presenter: ProjectsPresentationLogic?
    
    init(presenter: ProjectsPresentationLogic) {
        self.presenter = presenter
    }
}
