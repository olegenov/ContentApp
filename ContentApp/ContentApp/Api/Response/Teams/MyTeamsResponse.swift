//
//  MyTeamsResponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.03.2024.
//

import Foundation

struct MyTeamsResponse: Codable {
    var teams: [TeamResponse]
    var request_id: Int
}
