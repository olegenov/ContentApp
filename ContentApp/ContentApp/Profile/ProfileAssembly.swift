//
//  ProfileAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

enum ProfileAssembly {
    static func build() -> UIViewController {
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor(presenter: presenter, apiService: APIService())
        let viewController = ProfileViewController(interactor: interactor)
        
        viewController.router = ProfileRouter(viewController: viewController)
        presenter.viewController = viewController
        
        return viewController
    }
}
