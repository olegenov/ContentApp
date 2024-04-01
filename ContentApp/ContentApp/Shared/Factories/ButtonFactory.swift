//
//  ButtonFactory.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

class ButtonFactory {
    enum Types {
        case active
        case regular
        case empty
    }
    
    static func createButton(type: ButtonFactory.Types, title: String) -> Button {
        switch type {
        case .active:
            return ButtonActive(title)
        case .regular:
            return ButtonRegular(title)
        case .empty:
            return ButtonEmpty(title)
        }
    }
    
    static func createIconButton(type: IconFactory.Types) -> Button {
        return IconButton(type)
    }
}
