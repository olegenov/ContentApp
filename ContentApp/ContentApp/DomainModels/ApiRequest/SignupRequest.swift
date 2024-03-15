//
//  SignupRequest.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

struct SignupRequest: Encodable {
    let username: String
    let password: String
    let firstname: String
    let surname: String
    let email: String
}
