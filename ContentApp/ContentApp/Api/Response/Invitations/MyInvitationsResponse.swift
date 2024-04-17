//
//  MyInvitationsResponse.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import Foundation

struct MyInvitationsResponse: Codable {
    let invitations: [InvitationResponse]
    let amount: Int
}
