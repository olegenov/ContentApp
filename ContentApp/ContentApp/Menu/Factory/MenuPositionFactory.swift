//
//  MenuPositionFactory.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

class MenuPositionFactory {
    enum Types {
        case projects
        case profile
        case about
        case teams
    }
    
    enum Constants {
        static var projectsText: String = "projects"
        static var profileText: String = "profile"
        static var aboutText: String = "about"
        static var teamsText: String = "teams"
    }
    
    static func createMenuPosition(type: Types, active: Bool) -> MenuPosition {
        let position: MenuPosition
        
        switch type {
        case .about:
            position = MenuPosition(Constants.aboutText)
        case .profile:
            position = MenuPosition(Constants.profileText)
        case .projects:
            position = MenuPosition(Constants.projectsText)
        case .teams:
            position = MenuPosition(Constants.teamsText)
        }
        
        return position
    }
}
