//
//  InvitationRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.04.2024.
//

import UIKit

protocol InvitationsRouterProtocol {
    func navigateToTeams()
}

class InvitationsRouter: InvitationsRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToTeams() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
