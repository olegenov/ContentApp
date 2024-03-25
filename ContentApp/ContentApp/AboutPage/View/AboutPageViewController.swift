//
//  AboutPageViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

protocol AboutPageDisplayLogic {
    
}

class AboutPageViewController: UIViewController, AboutPageDisplayLogic {
    var interactor: AboutPageBusinessLogic?
    
    init(interactor: AboutPageBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
