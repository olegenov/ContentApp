//
//  NewProjectAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

enum NewProjectAssembly {
    static func build() -> UIViewController {
        let presenter = NewProjectPresenter()
        let interactor = NewProjectInteractor(presenter: presenter, apiService: APIService())
        let viewController = NewProjectViewController(interactor: interactor)
        
        viewController.router = NewProjectRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
