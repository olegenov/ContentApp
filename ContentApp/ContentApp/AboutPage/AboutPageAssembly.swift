//
//  AboutPageAssembly.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

enum AboutPageAssembly {
    static func build() -> UIViewController {
        let presenter = AboutPagePresenter()
        let interactor = AboutPageInteractor(presenter: presenter)
        let viewController = AboutPageViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
