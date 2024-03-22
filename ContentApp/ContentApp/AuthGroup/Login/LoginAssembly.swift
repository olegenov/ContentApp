//
//  LoginAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

enum LoginAssembly {
    static func build() -> UIViewController {
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(presenter: presenter, apiService: APIService())
        let viewController = LoginViewController(interactor: interactor)
        
        viewController.router = LoginRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
