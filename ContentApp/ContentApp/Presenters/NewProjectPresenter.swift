//
//  NewProjectPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import Foundation

protocol NewProjectPresentationLogic {
    func presentError(errors: [String])
    func handleSuccessCreation()
}

class NewProjectPresenter: NewProjectPresentationLogic {
    var viewController: NewProjectDisplayLogic?
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
    
    func handleSuccessCreation() {
        viewController?.handleSuccessCreation()
    }
}
