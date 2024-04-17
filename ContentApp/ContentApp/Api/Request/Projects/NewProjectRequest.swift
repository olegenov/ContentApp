//
//  NewProject.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import Foundation

struct NewProjectRequest: Encodable {
    let name: String
    var team_id: Int
}
