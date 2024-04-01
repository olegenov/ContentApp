//
//  SinglePostResponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 01.04.2024.
//

import Foundation

struct SinglePostResponse: Codable {
    let project_name: String
    let info: PostResponse
}
