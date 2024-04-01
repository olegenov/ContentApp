//
//  PostsResponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 30.03.2024.
//

import Foundation

struct ProjectPostsResponse: Codable {
    let name: String
    let posts: [PostResponse]
}
