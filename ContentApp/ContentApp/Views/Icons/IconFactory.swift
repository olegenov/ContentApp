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
    }
    
    enum Constants {
        static let menuName: String = "menu"
        static let profileName: String = "profile"
    }
    
    static func createIcon(type: IconFactory.Types) -> Icon {
        switch type {
        
        case .menu:
            return Icon(Constants.menuName)
        case .profile:
            return Icon(Constants.profileName)
        }
    }
}
