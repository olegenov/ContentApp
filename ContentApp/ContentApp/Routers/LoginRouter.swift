//
//  LoginRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

protocol LoginRouterProtocol {
    func navigateToSignup()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToSignup() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
