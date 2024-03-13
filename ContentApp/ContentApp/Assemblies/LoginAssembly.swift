//
//  LoginAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

enum LoginAssembly {
    static func build() -> UIViewController {
        let presenter = LoginFormPresenter()
        let interactor = LoginFormInteractor(presenter: presenter, apiService: APIService(), tokenManager: TokenManager())
        let viewController = LoginViewController(interactor: interactor)
        
        viewController.router = LoginRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
