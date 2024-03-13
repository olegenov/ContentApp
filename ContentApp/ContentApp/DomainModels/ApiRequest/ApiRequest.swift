//
//  ApiRequest.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

protocol ApiRequest {
    func toDict() -> [String: Any]
}
