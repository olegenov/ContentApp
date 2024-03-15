//
//  ProjectsRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

protocol ProjectsRouterProtocol {
    func navigateToProjectCreation()
}

class ProjectsRouter: ProjectsRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToProjectCreation() {
        let newProjectVC = NewProjectAssembly.build()
        viewController?.navigationController?.pushViewController(newProjectVC, animated: true)
    }
}
