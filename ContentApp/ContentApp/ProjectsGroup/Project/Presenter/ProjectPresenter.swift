//
//  ProjectPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.03.2024.
//

import Foundation

protocol ProjectPresentationLogic {
    func displayPosts(title: String, posts: [Post])
    func presentError(errors: [String])
}

class ProjectPresenter: ProjectPresentationLogic {
    var viewController: ProjectDisplayLogic?
    
    func displayPosts(title: String, posts: [Post]) {
        viewController?.displayTitle(title)
        viewController?.displayPosts(posts)
    }
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
}
