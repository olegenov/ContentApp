//
//  PostInfo.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.04.2024.
//

import Foundation

struct PostInfo: Codable {
    var title: String
    var assign: String
    var publishing: Date
    var deadline: Date
    var content: String
    var projectName: String
}
