//
//  TeamAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import UIKit

enum TeamAssembly {
    static func build(teamId: Int) -> UIViewController {
        let presenter = TeamPresenter()
        let interactor = TeamInteractor(presenter: presenter, apiService: APIService())
        let viewController = TeamViewController(interactor: interactor, teamId: teamId)
        
        viewController.router = TeamRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
