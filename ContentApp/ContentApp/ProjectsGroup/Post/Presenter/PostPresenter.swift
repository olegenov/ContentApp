//
//  PostPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import Foundation

protocol PostPresentationLogic {
    func displayPostInfo(post: Post)
    func presentError(errors: [String])
}

class PostPresenter: PostPresentationLogic {
    var viewController: PostDisplayLogic?
    
    func displayPostInfo(post: Post) {
        viewController?.displayPostInfo(post)
    }
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
}
