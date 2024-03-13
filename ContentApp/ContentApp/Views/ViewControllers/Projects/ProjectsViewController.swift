//
//  ProjectsViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

protocol ProjectsDisplayLogic {
}

class ProjectsViewController: UIViewController, ProjectsDisplayLogic {
    enum Constants {
    }
    
    var interactor: ProjectsBusinessLogic?
    var router: ProjectsRouterProtocol?
    
    init(interactor: ProjectsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTemplate()
        configureUI()
    }
    
    private func configureUI() {
        
    }
}

