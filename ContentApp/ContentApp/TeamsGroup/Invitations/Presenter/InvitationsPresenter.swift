//
//  InvitationsInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.04.2024.
//

import Foundation

protocol InvitationsPresentationLogic {
    func displayInvitations(invitations: [Invitation])
    func presentError(errors: [String])
}

class InvitationsPresenter: InvitationsPresentationLogic {
    var viewController: InvitationsDisplayLogic?
    
    func displayInvitations(invitations: [Invitation]) {
        viewController?.displayInvitations(invitations)
    }
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
}

