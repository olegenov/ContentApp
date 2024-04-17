//
//  TeamsPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import Foundation

protocol TeamsPresentationLogic {
    func displayTeams(teams: [TeamCard])
    func presentError(errors: [String])
    func displayInvitationsAmount(amount: Int)
}

class TeamsPresenter: TeamsPresentationLogic {
    var viewController: TeamsDisplayLogic?
    
    func displayTeams(teams: [TeamCard]) {
        viewController?.displayTeams(teams)
    }
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
    
    func displayInvitationsAmount(amount: Int) {
        viewController?.updateInvitationAmount(amount: amount)
    }
}
