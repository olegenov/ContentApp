//
//  RootAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

enum RootAssembly {
    static func build() -> UIViewController {
        let presenter = RootPresenter()
        let interactor = RootInteractor(presenter: presenter, apiService: APIService())
        let viewController = RootViewController(interactor: interactor)
        
        viewController.router = RootRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
