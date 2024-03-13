//
//  LoginFormPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 12.03.2024.
//

import Foundation

protocol SignupPresentationLogic {
    func presentValidationError(errors: [String])
}

class SignupFormPresenter: SignupPresentationLogic {
    var viewController: SignupDisplayLogic?
    
    func presentValidationError(errors: [String]) {
        for error in errors {
            viewController?.displayValidationError(error)
        }
    }
}
