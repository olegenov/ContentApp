//
//  LoginRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

protocol LoginRouterProtocol {
    func navigateToSignup()
    func navigateToMenu()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToSignup() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToMenu() {
        let menuVC = MenuAssembly.build()
        viewController?.navigationController?.pushViewController(menuVC, animated: true)
    }
}
