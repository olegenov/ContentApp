//
//  ProjectInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.03.2024.
//

import Foundation

protocol ProjectBusinessLogic {
    func loadPosts(id: Int)
}

final class ProjectInteractor: ProjectBusinessLogic {
    var presenter: ProjectPresentationLogic?
    var apiService: APIService
    private var apiUrl: String = "projects/"
    
    init(presenter: ProjectPresentationLogic, apiService: APIService) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func loadPosts(id: Int) {
        apiService.fetchData(urlString: apiUrl + String(format: "%d", id), responseType: ProjectPostsResponse.self, token: true) { result in
            switch result {
            case .success(let postsResponse):
                self.handleSuccessResponse(postsResponse)
            case .failure(let error):
                self.handleFailureResponse(error)
            }
        }
    }
    
    private func handleSuccessResponse(_ postsResponse: ProjectPostsResponse?) {
        guard let response = postsResponse else {
            return
        }

        var title = response.name
        var posts: [Post] = []
        
        for postResponse in response.posts {
            var post = Post(
                id: postResponse.id,
                title: postResponse.title ?? "",
                assign: nil,
                deadline: postResponse.deadline?.toDate() ?? Date.now,
                publishing: postResponse.publishing?.toDate() ?? Date.now, 
                content: postResponse.content,
                projectName: title
            )
            
            guard let userResponse = postResponse.assign else {
                posts.append(post)
                continue
            }
            
            let postAssign = User(
                id: userResponse.id,
                username: userResponse.username,
                firstname: userResponse.firstname,
                surname: userResponse.surname,
                email: userResponse.email
            )
            
            post.assign = postAssign
            posts.append(post)
        }
        
        self.presenter?.displayPosts(title: title, posts: posts)
    }
    
    private func handleFailureResponse(_ error: ApiError) {
        self.presenter?.presentError(errors: [error.message])
    }
}
