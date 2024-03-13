//
//  RootPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

protocol RootPresentationLogic {
    func presentError(errors: [String])
    func handleSuccessLogin()
    func switchToSignup()
}

class RootPresenter: RootPresentationLogic {
    var viewController: RootDisplayLogic?
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
    
    func handleSuccessLogin() {
        viewController?.openProjectsPage()
    }
    
    func switchToSignup() {
        viewController?.openSignupPage()
    }
}
