//
//  InvitationRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import UIKit

protocol TeamRouterProtocol {
    func navigateToMenu()
    func navigateToInvitationCreation(teamId: Int)
    func navigateToTeams()
}

class TeamRouter: TeamRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToInvitationCreation(teamId: Int) {
        let newInvitationVC = NewInvitationAssembly.build(teamId: teamId)
        viewController?.navigationController?.pushViewController(newInvitationVC, animated: true)
    }
    
    func navigateToMenu() {
        let menuVC = MenuAssembly.build()
        viewController?.navigationController?.pushViewController(menuVC, animated: true)
    }
    
    func navigateToTeams() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
