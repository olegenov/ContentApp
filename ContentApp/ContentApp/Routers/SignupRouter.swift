//
//  AuthRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

protocol SignupRouterProtocol {
    func navigateToLogin()
}

class SignupRouter: SignupRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToLogin() {
        let loginViewController = LoginAssembly.build()
        viewController?.navigationController?.pushViewController(loginViewController, animated: true)
    }
}
