//
//  User.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

struct User {
    private var username: String
    private var password: String
    
    private var loggedIn: Bool = false
    
    public func isLoggedIn() -> Bool {
        return loggedIn
    }
    
    public init(username: String, password: String, loggedIn: Bool) {
        self.username = username
        self.password = password
        self.loggedIn = loggedIn
    }
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
