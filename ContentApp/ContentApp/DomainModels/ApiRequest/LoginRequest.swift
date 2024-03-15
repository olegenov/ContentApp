//
//  LoginResponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 12.03.2024.
//

import Foundation

struct LoginRequest: Encodable {
    let username: String
    let password: String
}
