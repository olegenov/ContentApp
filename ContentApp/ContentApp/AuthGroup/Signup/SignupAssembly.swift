//
//  Assembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

enum SignupAssembly {
    static func build() -> UIViewController {
        let presenter = SignupPresenter()
        let interactor = SignupInteractor(presenter: presenter, apiService: APIService())
        let viewController = SignupViewController(interactor: interactor)
        
        viewController.router = SignupRouter(viewController: viewController)
        presenter.viewController = viewController
        
        return viewController
    }
}
