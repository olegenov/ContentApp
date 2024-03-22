//
//  ProfileRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

protocol ProfileRouterProtocol {
    func getBack()
    func navigateToSignup()
}

class ProfileRouter: ProfileRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func getBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToSignup() {
        let signupVc = SignupAssembly.build()
        viewController?.navigationController?.pushViewController(signupVc, animated: true)
    }
}
