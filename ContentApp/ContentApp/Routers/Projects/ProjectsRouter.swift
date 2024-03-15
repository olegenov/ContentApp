//
//  ProjectsRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

protocol ProjectsRouterProtocol {
    func navigateToMenu()
    func navigateToProjectCreation()
    func navigateToProfile()
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
    
    func navigateToMenu() {
        let menuVC = MenuAssembly.build()
        viewController?.navigationController?.pushViewController(menuVC, animated: true)
    }
    
    func navigateToProfile() {
        let profileVC = ProfileAssembly.build()
        viewController?.navigationController?.pushViewController(profileVC, animated: true)
    }
}
