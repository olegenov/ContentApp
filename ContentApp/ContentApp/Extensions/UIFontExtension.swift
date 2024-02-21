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
        case regular
    }
    
    enum Constants {
        static let defaultFontSize: CGFloat = 16
        static let boldTextFont: String = "Nunito-Bold"
        static let defaultTextFont: String = "Nunito-Regular"
        static let titleFontSize: CGFloat = 32
        static let nameLabelFontSize: CGFloat = 24
        static let buttonFontSize: CGFloat = 16
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
        case .regular:
            return UIFont(name: Constants.defaultTextFont, size: Constants.defaultFontSize) ?? defaultFont()
        }
    }
}
