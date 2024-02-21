//
//  ButtonFactory.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

class ButtonFactory {
    static func createButton(type: Button.Types, title: String) -> Button {
        switch type {
        case .active:
            return ButtonActive(title)
        case .regular:
            return RegularButton(title)
        }
    }
}

