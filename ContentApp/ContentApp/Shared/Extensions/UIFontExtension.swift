//
//  UIFontExtension.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

extension UIFont {
    public enum Styles {
        case nameLabel
        case title
        case buttonActive
        case button
        case regular
        case placeholder
        case formInput
        case inputError
        case cardTitle
    }
    
    enum Constants {
        static let defaultFontSize: CGFloat = 16
        static let boldTextFont: String = "Nunito-Bold"
        static let semiboldTextFont: String = "Nunito-SemiBold"
        static let defaultTextFont: String = "Nunito-Regular"
        static let titleFontSize: CGFloat = 32
        static let nameLabelFontSize: CGFloat = 24
        static let buttonFontSize: CGFloat = 16
        static let cardTitleFontSize: CGFloat = 20
    }
    
    private static func defaultFont() -> UIFont {
        return UIFont.systemFont(ofSize: Constants.defaultFontSize, weight: .regular)
    }
    
    public static func appFont(_ style: Styles) -> UIFont {
        switch style {
        case .title:
            return UIFont(name: Constants.boldTextFont, size: Constants.titleFontSize) ?? defaultFont()
        case .nameLabel:
            return UIFont(name: Constants.boldTextFont, size: Constants.nameLabelFontSize) ?? defaultFont()
        case .buttonActive:
            return UIFont(name: Constants.boldTextFont, size: Constants.buttonFontSize) ?? defaultFont()
        case .button:
            return UIFont(name: Constants.defaultTextFont, size: Constants.buttonFontSize) ?? defaultFont()
        case .regular:
            return UIFont(name: Constants.defaultTextFont, size: Constants.defaultFontSize) ?? defaultFont()
        case .placeholder:
            return UIFont(name: Constants.defaultTextFont, size: Constants.defaultFontSize) ?? defaultFont()
        case .formInput:
            return UIFont(name: Constants.defaultTextFont, size: Constants.defaultFontSize) ?? defaultFont()
        case .inputError:
            return UIFont(name: Constants.defaultTextFont, size: Constants.defaultFontSize) ?? defaultFont()
        case .cardTitle:
            return UIFont(name: Constants.semiboldTextFont, size: Constants.cardTitleFontSize) ?? defaultFont()
        }
    }
}
