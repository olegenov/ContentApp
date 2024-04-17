//
//  TeamResponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.03.2024.
//

import Foundation

struct TeamResponse: Codable {
    var id: Int
    var name: String
    var creator: UserResponse
    var users: [UserResponse]
}
