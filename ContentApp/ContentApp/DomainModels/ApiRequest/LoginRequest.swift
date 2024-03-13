//
//  LoginResponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 12.03.2024.
//

import Foundation

class LoginRequest: ApiRequest {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    public func toDict() -> [String : Any] {
        return [
            "username": username,
            "password": password
        ]
    }
}
