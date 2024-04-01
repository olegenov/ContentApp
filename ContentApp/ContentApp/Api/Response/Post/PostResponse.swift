//
//  PostResponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 30.03.2024.
//

import Foundation

struct PostResponse: Codable {
    let id: Int
    let title: String?
    let assign: UserResponse?
    let deadline: DateTimeResponse?
    let publishing: DateTimeResponse?
    let content: String
}
