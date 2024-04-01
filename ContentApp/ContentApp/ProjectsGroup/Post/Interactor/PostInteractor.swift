//
//  PostInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import Foundation

protocol PostBusinessLogic {
    func loadPost(projectId: Int, postId: Int)
}

final class PostInteractor: PostBusinessLogic {
    var presenter: PostPresentationLogic?
    var apiService: APIService
    private var apiUrl: String = "projects/%d/post/"
    
    init(presenter: PostPresentationLogic, apiService: APIService) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func loadPost(projectId: Int, postId: Int) {
        apiService.fetchData(urlString: String(format: apiUrl + "%d", projectId, postId), responseType: SinglePostResponse.self, token: true) { result in
            switch result {
            case .success(let postResponse):
                self.handleSuccessResponse(postResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessResponse(_ postResponse: SinglePostResponse?) {
        guard let response = postResponse else {
            return
        }

        var postResponse = response.info
        
        var title = response.project_name
        
        var post = Post(
            id: postResponse.id,
            title: postResponse.title ?? "",
            assign: nil,
            deadline: postResponse.deadline?.toDate() ?? Date.now,
            publishing: postResponse.publishing?.toDate() ?? Date.now,
            content: postResponse.content,
            projectName: title
        )
            
        let userResponse = postResponse.assign
            
        guard let userResponse = postResponse.assign else {
            self.presenter?.displayPostInfo(post: post)
            return
        }
            
        let postAssign = User(
            id: userResponse.id,
            username: userResponse.username,
            firstname: userResponse.firstname,
            surname: userResponse.surname,
            email: userResponse.email
        )
        
        post.assign = postAssign
        self.presenter?.displayPostInfo(post: post)
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
    }
}
