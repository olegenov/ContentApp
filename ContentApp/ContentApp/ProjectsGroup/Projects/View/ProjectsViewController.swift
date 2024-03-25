//
//  ProjectsViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

protocol ProjectsDisplayLogic {
    func displayError(_ error: String)
    func displayProjects(_ projects: [Project])
}

class ProjectsViewController: BaseViewController, ProjectsDisplayLogic {
    enum Constants {
        static let sideOffset: CGFloat = 16
        static let title: String = "projects"
    }
    
    var interactor: ProjectsBusinessLogic?
    var router: ProjectsRouterProtocol?
    private let cards = CardList()
    
    init(interactor: ProjectsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.loadProjects()
    }
    
    internal override func configureUI() {
        configureTitle(title: Constants.title)
        configureCards()
    }
    
    internal override func configureNav() {
        let menuButton = IconButton(.menu)
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        let profileButton = IconButton(.profile)
        profileButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
        let navBuilder = NavBuilder(nav: self.nav)
        navBuilder.addLeftButton(button: menuButton)
        navBuilder.addRightButton(button: profileButton)
        navBuilder.addNameLabel()
        
        displayNav()
    }
    
    private func configureCards() {
        cards.configureAddCardTapAction(self.handleCreatingNewProject)
        
        cards.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cards)
        
        NSLayoutConstraint.activate([
            cards.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            cards.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            cards.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            cards.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func displayProjects(_ projects: [Project]) {
        var cardsData: [CardData] = []
        
        for project in projects {
            cardsData.append(CardData(title: project.name))
        }
        
        cards.updateData(cardsData)
    }
    
    func handleCreatingNewProject() {
        router?.navigateToProjectCreation()
    }
    
    @objc func openMenu() {
        router?.navigateToMenu()
    }
    
    @objc func openProfile() {
        router?.navigateToProfile()
    }
}

