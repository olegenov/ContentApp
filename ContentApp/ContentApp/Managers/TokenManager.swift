//
//  TokenManager.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.02.2024.
//

import UIKit

class TokenManager {
    static let shared = TokenManager()

    private var accessToken: String?

    func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
        self.accessToken = token
    }

    func getToken() -> String? {
        if accessToken == nil {
            self.accessToken = UserDefaults.standard.string(forKey: "accessToken")
        }
        return accessToken
    }
}
