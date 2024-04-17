//
//  TeamsAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import UIKit

enum TeamsAssembly {
    static func build() -> UIViewController {
        let presenter = TeamsPresenter()
        let interactor = TeamsInteractor(presenter: presenter, apiService: APIService())
        let viewController = TeamsViewController(interactor: interactor)
        
        viewController.router = TeamsRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
