//
//  TeamsRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import UIKit

protocol TeamsRouterProtocol {
    func navigateToMenu()
    func navigateToTeamCreation()
    func navigateToProfile()
    func navigateToTeam(id: Int)
    func navigateToInvitations()
}

class TeamsRouter: TeamsRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToTeamCreation() {
        let newTeamVC = NewTeamAssembly.build()
        viewController?.navigationController?.pushViewController(newTeamVC, animated: true)
    }
    
    func navigateToMenu() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToProfile() {
        let profileVC = ProfileAssembly.build()
        viewController?.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func navigateToTeam(id: Int) {
        let teamVC = TeamAssembly.build(teamId: id)
        viewController?.navigationController?.pushViewController(teamVC, animated: true)
    }
    
    func navigateToInvitations() {
        let invitationsVC = InvitationsAssembly.build()
        viewController?.navigationController?.pushViewController(invitationsVC, animated: true)
    }
}
