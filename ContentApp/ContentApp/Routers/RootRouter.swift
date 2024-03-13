//
//  RootRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

protocol RootRouterProtocol {
    func navigateToSignup()
    func navigateToProjects()
}

class RootRouter: RootRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToSignup() {
        let signupVc = SignupAssembly.build()
        viewController?.navigationController?.pushViewController(signupVc, animated: true)
    }
    
    func navigateToProjects() {
        let projectsVC = ProjectsAssembly.build()
        viewController?.navigationController?.pushViewController(projectsVC, animated: true)
    }
}
