//
//  InvitationRequest.swift
//  ContentApp
//
//  Created by Никита Китаев on 14.04.2024.
//

import Foundation

struct InvitationRequest: Encodable {
    let team_id: Int
    let receiver_username: String
}
