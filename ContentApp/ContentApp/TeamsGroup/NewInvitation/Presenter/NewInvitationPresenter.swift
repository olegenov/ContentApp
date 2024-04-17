//
//  NewInvitationPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import Foundation

protocol NewInvitationPresentationLogic {
    func presentError(errors: [String])
    func handleSuccessCreation()
}

class NewInvitationPresenter: NewInvitationPresentationLogic {
    var viewController: NewInvitationDisplayLogic?
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
    
    func handleSuccessCreation() {
        viewController?.handleSuccessCreation()
    }
}
