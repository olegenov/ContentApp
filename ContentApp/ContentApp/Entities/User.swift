//
//  User.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let username: String
    let firstname: String
    let surname: String
    let email: String
}
