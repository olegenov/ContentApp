//
//  SignupRequest.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

class SignupRequest: Encodable {
    let username: String
    let password: String
    let firstname: String
    let surname: String
    let email: String
    
    init(username: String, password: String, firstname: String, surname: String, email: String) {
        self.username = username
        self.password = password
        self.firstname = firstname
        self.surname = surname
        self.email = email
    }
}
