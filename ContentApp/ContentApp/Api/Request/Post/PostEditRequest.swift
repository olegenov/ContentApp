//
//  PostRequest.swift
//  ContentApp
//
//  Created by Никита Китаев on 17.04.2024.
//

import Foundation

struct PostEditRequest: Encodable {
    let title: String
    let assign: String
    let publishing: String
    let deadline: String
    let content: String
}
