//
//  PostRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import UIKit

protocol PostRouterProtocol {
    func navigateToProject()
}

class PostRouter: PostRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToProject() {
        viewController?.dismiss(animated: true)
    }
}
