//
//  ProjectRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.03.2024.
//

import UIKit

protocol ProjectRouterProtocol {
    func navigateToMenu()
    func navigateToPostCreation()
    func navigateToProjects()
    func navigateToPost(projectId: Int, postId: Int)
}

class ProjectRouter: ProjectRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToPostCreation() {
//        let newProjectVC = NewProjectAssembly.build()
//        viewController?.navigationController?.pushViewController(newProjectVC, animated: true)
    }
    
    func navigateToMenu() {
        let menuVC = MenuAssembly.build()
        viewController?.navigationController?.pushViewController(menuVC, animated: true)
    }
    
    func navigateToProjects() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToPost(projectId: Int, postId: Int) {
        let postVC = PostAssembly.build(projectId: projectId, postId: postId)
        viewController?.present(postVC, animated: true)
    }
}
