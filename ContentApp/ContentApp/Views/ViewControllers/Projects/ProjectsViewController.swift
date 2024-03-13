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
        static let navTopOffset: CGFloat = 70
        static let navSideOffset: CGFloat = 24
        static let navHeight: CGFloat = 35
    }
    
    var interactor: ProjectsBusinessLogic?
    var router: ProjectsRouterProtocol?
    var nav =  UIStackView()
    
    init(interactor: ProjectsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        configureTemplate()
        configureUI()
    }
    
    private func configureUI() {
        configureNav()
    }
    
    private func configureNav() {
        var menuIcon = IconFactory.createIcon(type: .menu)
        var profileIcon = IconFactory.createIcon(type: .profile)
        
        nav.addArrangedSubview(menuIcon)
        nav.addArrangedSubview(profileIcon)
        nav.distribution = .equalSpacing
        nav.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nav)
        
        NSLayoutConstraint.activate([
            nav.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nav.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.navTopOffset),
            nav.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.navSideOffset),
            nav.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.navSideOffset),
            nav.heightAnchor.constraint(equalToConstant: Constants.navHeight)
        ])
    }
}

