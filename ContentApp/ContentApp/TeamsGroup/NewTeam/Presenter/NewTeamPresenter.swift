//
//  NewTeamPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 11.04.2024.
//

import Foundation

protocol NewTeamPresentationLogic {
    func presentError(errors: [String])
    func handleSuccessCreation()
}

class NewTeamPresenter: NewTeamPresentationLogic {
    var viewController: NewTeamDisplayLogic?
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
    
    func handleSuccessCreation() {
        viewController?.handleSuccessCreation()
    }
}

