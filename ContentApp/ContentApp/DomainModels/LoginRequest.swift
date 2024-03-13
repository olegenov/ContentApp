//
//  LoginResponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 12.03.2024.
//

import Foundation

class LoginRequest: Encodable {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
