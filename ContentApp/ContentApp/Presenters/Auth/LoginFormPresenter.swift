//
//  LoginFormPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

protocol LoginPresentationLogic {
    func presentError(errors: [String])
    func handleSuccessLogin()
}

class LoginFormPresenter: LoginPresentationLogic {
    var viewController: LoginDisplayLogic?
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
    
    func handleSuccessLogin() {
        viewController?.handleSuccessLogin()
    }
}
