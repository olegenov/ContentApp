//
//  MenuRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

protocol MenuRouterProtocol {
    func navigateToProjects()
    func navigateToProfile()
    func navigateToTeams()
}

class MenuRouter: MenuRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToProjects() {
        let ProjectsVC = ProjectsAssembly.build()
        viewController?.navigationController?.pushViewController(ProjectsVC, animated: true)
    }
    
    func navigateToProfile() {
        let profileVC = ProfileAssembly.build()
        viewController?.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func navigateToTeams() {
        let teamsVC = TeamsAssembly.build()
        viewController?.navigationController?.pushViewController(teamsVC, animated: true)
    }
}
