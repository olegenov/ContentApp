//
//  Post.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.03.2024.
//

import Foundation

struct Post {
    let id: Int
    var title: String
    var assign: User?
    var deadline: Date
    var publishing: Date
    var content: String
    var projectName: String
}
