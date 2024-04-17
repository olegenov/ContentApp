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
        case empty
        case accept
        case reject
        case reload
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
        static let calendarBig: String = "calendar_2x"
        static let deadlineName: String = "deadline"
        static let deadlineBig: String = "deadline_2x"
        static let assignName: String = "assign"
        static let assignBig: String = "assign_2x"
        static let acceptName: String = "accept"
        static let rejectName: String = "reject"
        static let reloadName: String = "reload"
    }
    
    static func createIcon(type: IconFactory.Types, big: Bool = false) -> Icon {
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
            if big {
                return Icon(Constants.calendarBig)
            }
            return Icon(Constants.calendarName)
        case .deadline:
            if big {
                return Icon(Constants.deadlineBig)
            }
            return Icon(Constants.deadlineName)
        case .assign:
            if big {
                return Icon(Constants.assignBig)
            }
            return Icon(Constants.assignName)
        case .accept:
            return Icon(Constants.acceptName)
        case .reject:
            return Icon(Constants.rejectName)
        case .empty:
            return Icon()
        case .reload:
            return Icon(Constants.reloadName)
        }
    }
}
