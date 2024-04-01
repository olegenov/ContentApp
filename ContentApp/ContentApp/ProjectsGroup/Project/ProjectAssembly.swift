//
//  ProjectAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.03.2024.
//

import UIKit

enum ProjectAssembly {
    static func build(projectId: Int) -> UIViewController {
        let presenter = ProjectPresenter()
        let interactor = ProjectInteractor(presenter: presenter, apiService: APIService())
        let viewController = ProjectViewController(interactor: interactor, projectId: projectId)
        
        viewController.router = ProjectRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
