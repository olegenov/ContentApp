//
//  NewTeamRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 11.04.2024.
//

import UIKit

protocol NewTeamRouterProtocol {
    func navigateToTeams()
}

class NewTeamRouter: NewTeamRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToTeams() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
