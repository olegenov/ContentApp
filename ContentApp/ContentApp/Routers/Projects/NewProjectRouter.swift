//
//  NewProjectRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

protocol NewProjectRouterProtocol {
    func navigateToProjects()
}

class NewProjectRouter: NewProjectRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToProjects() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

