//
//  NewInvitationRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import UIKit

protocol NewInvitationRouterProtocol {
    func navigateToTeam()
}

class NewInvitationRouter: NewInvitationRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToTeam() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
