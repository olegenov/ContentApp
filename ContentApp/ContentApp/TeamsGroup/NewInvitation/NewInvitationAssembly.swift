//
//  NewInvitationAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import UIKit

enum NewInvitationAssembly {
    static func build(teamId: Int) -> UIViewController {
        let presenter = NewInvitationPresenter()
        let interactor = NewInvitationInteractor(presenter: presenter, apiService: APIService())
        let viewController = NewInvitationViewController(teamId: teamId, interactor: interactor)
        
        viewController.router = NewInvitationRouter(viewController: viewController)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
