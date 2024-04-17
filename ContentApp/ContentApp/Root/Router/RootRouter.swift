//
//  RootRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

protocol RootRouterProtocol {
    func navigateToSignup()
    func navigateToMenu()
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
    
    func navigateToMenu() {
        let menuVC = MenuAssembly.build()
        viewController?.navigationController?.pushViewController(menuVC, animated: true)
    }
}
