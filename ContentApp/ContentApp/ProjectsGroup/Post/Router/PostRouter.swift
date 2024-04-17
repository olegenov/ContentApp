//
//  PostRouter.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import UIKit

protocol PostRouterProtocol {
    func navigateToProject()
}

class PostRouter: PostRouterProtocol {
    weak var viewController: BaseViewController?
    
    init(viewController: BaseViewController) {
        self.viewController = viewController
    }
    
    func navigateToProject() {
        viewController?.onClose?()
        viewController?.dismiss(animated: true)
    }
}
