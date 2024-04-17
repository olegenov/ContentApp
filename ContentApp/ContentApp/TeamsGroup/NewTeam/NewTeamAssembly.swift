//
//  NewTeamAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 11.04.2024.
//

import UIKit

enum NewTeamAssembly {
    static func build() -> UIViewController {
        let presenter = NewTeamPresenter()
        let interactor = NewTeamInteractor(presenter: presenter, apiService: APIService())
        let viewController = NewTeamViewController(interactor: interactor)
        
        viewController.router = NewTeamRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
