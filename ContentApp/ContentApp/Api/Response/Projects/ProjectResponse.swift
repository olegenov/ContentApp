//
//  ProjectResponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import Foundation

struct ProjectResponse: Codable {
    var id: Int
    var name: String
    var creator: UserResponse
    var team: ProjectTeamResponse
}
