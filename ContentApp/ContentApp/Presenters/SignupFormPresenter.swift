//
//  LoginFormPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 12.03.2024.
//

import Foundation

protocol SignupPresentationLogic {
    func presentError(errors: [String])
    func handleSuccessSignup()
}

class SignupFormPresenter: SignupPresentationLogic {
    var viewController: SignupDisplayLogic?
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
    
    func handleSuccessSignup() {
        viewController?.handleSuccessSignup()
    }
}
