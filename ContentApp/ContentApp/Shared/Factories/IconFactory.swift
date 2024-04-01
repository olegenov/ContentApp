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
        case down
        case team
        case cards
        case calendar
        case deadline
        case assign
    }
    enum Constants {
        static let menuName: String = "menu"
        static let profileName: String = "profile"
        static let plusName: String = "plus"
        static let backName: String = "back"
        static let downName: String = "down"
        static let teamName: String = "team"
        static let cardsName: String = "cards"
        static let calendarName: String = "calendar"
        static let deadlineName: String = "deadline"
        static let assignName: String = "assign"
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
        case .down:
            return Icon(Constants.downName)
        case .team:
            return Icon(Constants.teamName)
        case .cards:
            return Icon(Constants.cardsName)
        case .calendar:
            return Icon(Constants.calendarName)
        case .deadline:
            return Icon(Constants.deadlineName)
        case .assign:
            return Icon(Constants.assignName)
        }
    }
}
