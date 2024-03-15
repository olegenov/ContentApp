//
//  ProjectsAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

enum ProjectsAssembly {
    static func build() -> UIViewController {
        let presenter = ProjectsPresenter()
        let interactor = ProjectsInteractor(presenter: presenter, apiService: APIService())
        let viewController = ProjectsViewController(interactor: interactor)
        
        viewController.router = ProjectsRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
