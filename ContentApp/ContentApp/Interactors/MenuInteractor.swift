//
//  MenuInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import Foundation

protocol MenuBusinessLogic {
}

class MenuInteractor: MenuBusinessLogic {
    var presenter: MenuPresentationLogic?

    init(presenter: MenuPresentationLogic) {
        self.presenter = presenter
    }
}
