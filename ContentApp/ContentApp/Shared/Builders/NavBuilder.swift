//
//  NavBuilder.swift
//  ContentApp
//
//  Created by Никита Китаев on 25.03.2024.
//

import UIKit

class NavBuilder {
    private var nav: Nav
    
    init(nav: Nav) {
        self.nav = nav
    }
    
    public func addLeftButton(button: Button) {
        nav.configureLeftButton(button: button)
    }
    
    public func addRightButton(button: Button) {
        nav.configureRightButton(button: button)
    }
    
    public func addNameLabel() {
        nav.configureNameLabel()
    }
}
