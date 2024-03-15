//
//  AboutPageInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import Foundation

protocol AboutPageBusinessLogic {
    
}

class AboutPageInteractor: AboutPageBusinessLogic {
    var presenter: AboutPagePresentationLogic?

    init(presenter: AboutPagePresentationLogic) {
        self.presenter = presenter
    }
}
