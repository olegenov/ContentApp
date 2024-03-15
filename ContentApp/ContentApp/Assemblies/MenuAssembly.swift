//
//  MenuAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

enum MenuAssembly {
    static func build() -> UIViewController {
        let presenter = MenuPresenter()
        let interactor = MenuInteractor(presenter: presenter)
        let viewController = MenuViewController(interactor: interactor)
        viewController.router = MenuRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
