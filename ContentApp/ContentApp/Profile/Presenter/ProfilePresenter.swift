//
//  ProfilePresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import Foundation

protocol ProfilePresentationLogic {
    func presentError(errors: [String])
    func switchToSignup()
    func updateUserInfo(response: UserResponse)
}

class ProfilePresenter: ProfilePresentationLogic {
    var viewController: ProfileDisplayLogic?
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
    
    func switchToSignup() {
        viewController?.openSignupPage()
    }
    
    func updateUserInfo(response: UserResponse) {
        viewController?.updateUserInfo(response: response)
    }
}
