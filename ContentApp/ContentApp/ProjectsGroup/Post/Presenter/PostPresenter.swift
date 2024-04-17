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
        var postInfo = PostInfo(
            title: post.title,
            assign: post.assign?.username ?? "none",
            publishing: post.publishing,
            deadline: post.deadline,
            content: post.content,
            projectName: post.projectName
        )
        
        viewController?.displayPostInfo(postInfo)
    }
    
    func presentError(errors: [String]) {
        for error in errors {
            viewController?.displayError(error)
        }
    }
}
