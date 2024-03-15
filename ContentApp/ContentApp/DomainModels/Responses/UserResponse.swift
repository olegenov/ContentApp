//
//  UserResponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

struct UserResponse: Codable {
    var id: Int
    var username: String
    var firstname: String
    var surname: String
    var email: String
}
