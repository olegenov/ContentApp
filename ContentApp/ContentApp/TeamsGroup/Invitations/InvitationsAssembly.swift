//
//  InvitationsAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.04.2024.
//

import UIKit

enum InvitationsAssembly {
    static func build() -> UIViewController {
        let presenter = InvitationsPresenter()
        let interactor = InvitationsInteractor(presenter: presenter, apiService: APIService())
        let viewController = InvitationsViewController(interactor: interactor)
        
        viewController.router = InvitationsRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
