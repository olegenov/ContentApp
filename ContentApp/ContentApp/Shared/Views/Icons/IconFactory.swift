//
//  IconFactory.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

class IconFactory {
    enum Types {
        case menu
        case profile
        case plus
        case back
    }
    enum Constants {
        static let menuName: String = "menu"
        static let profileName: String = "profile"
        static let plusName: String = "plus"
        static let backName: String = "back"
    }
    
    static func createIcon(type: IconFactory.Types) -> Icon {
        switch type {
        case .plus:
            return Icon(Constants.plusName)
        case .menu:
            return Icon(Constants.menuName)
        case .profile:
            return Icon(Constants.profileName)
        case .back:
            return Icon(Constants.backName)
        }
    }
}
