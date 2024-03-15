//
//  MenuPresenter.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import Foundation

protocol MenuPresentationLogic {
    func getMenuItems()
    func presentMenuItems(items: [String])
}

class MenuPresenter: MenuPresentationLogic{
    var viewController: MenuDisplayLogic?
    
    func getMenuItems() {
        viewController?.displayMenuItems(items: [])
    }

    func presentMenuItems(items: [String]) {
        viewController?.displayMenuItems(items: items)
    }
}
