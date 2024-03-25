//
//  ApiError.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

class ApiError: Error {
    var message: String
    var statusCode: Int
    
    init(_ message: String, _ statusCode: Int = 0) {
        self.message = message
        self.statusCode = statusCode
    }
}
