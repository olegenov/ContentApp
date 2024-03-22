//
//  MenuRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

protocol MenuRouterProtocol {
    func getBack()
    func navigateToAboutPage()
    func navigateToProjects()
    func navigateToProfile()
}

class MenuRouter: MenuRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func getBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToAboutPage() {
        let AboutPageVC = AboutPageAssembly.build()
        viewController?.navigationController?.pushViewController(AboutPageVC, animated: true)
    }
    
    func navigateToProjects() {
        let ProjectsVC = ProjectsAssembly.build()
        viewController?.navigationController?.pushViewController(ProjectsVC, animated: true)
    }
    
    func navigateToProfile() {
    }
}
