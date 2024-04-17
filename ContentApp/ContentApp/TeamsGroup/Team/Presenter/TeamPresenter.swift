//
//  TeamPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import Foundation

protocol TeamPresentationLogic {
    func displayUsers(title: String, users: [User], creatorId: Int)
    func presentError(errors: [String])
}

class TeamPresenter: TeamPresentationLogic {
    var viewController: TeamDisplayLogic?
    
    func displayUsers(title: String, users: [User], creatorId: Int) {
        viewController?.displayTitle(title)
        viewController?.displayUsers(users, creatorId: creatorId)
    }
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
}
