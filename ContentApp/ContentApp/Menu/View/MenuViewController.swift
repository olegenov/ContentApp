//
//  MenuViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

protocol MenuDisplayLogic {
    func displayMenuItems(items: [String])
}

class MenuViewController: BaseViewController, MenuDisplayLogic {
    enum Constants {
        static let topOffset: CGFloat = 110
        static let menuWidth: CGFloat = 250
        static let menuSpacing: CGFloat = 12
        static let sideOffset: CGFloat = 16
        static let backButtonTopOffset: CGFloat = 60
    }
    
    var interactor: MenuBusinessLogic?
    var router: MenuRouterProtocol?
    
    var projectsMenuPosition = MenuPositionFactory.createMenuPosition(type: .projects, active: false)
    var profileMenuPosition = MenuPositionFactory.createMenuPosition(type: .profile, active: false)
    var teamsMenuPosition = MenuPositionFactory.createMenuPosition(type: .teams, active: false)
    private let backButton: IconButton = IconButton(.back)
    
    var menuItems = UIStackView()
    
    init(interactor: MenuBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayMenuItems(items: [String]) {
    }
    
    internal override func configureUI() {
        configureMenu()
        configureActions()
    }
    
    private func configureMenu() {
        menuItems.translatesAutoresizingMaskIntoConstraints = false
        menuItems.spacing = Constants.menuSpacing
        menuItems.axis = .vertical
        menuItems.alignment = .leading
        
        view.addSubview(menuItems)
        
        for item in [projectsMenuPosition, profileMenuPosition, teamsMenuPosition] {
            item.translatesAutoresizingMaskIntoConstraints = false
            menuItems.addArrangedSubview(item)
        }
        
        NSLayoutConstraint.activate([
            menuItems.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            menuItems.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topOffset),
        ])
    }
    
    private func configureActions() {
        projectsMenuPosition.configurePositionTapAction(handleProjectsPositionTap)
        profileMenuPosition.configurePositionTapAction(handleProfilePositionTap)
        teamsMenuPosition.configurePositionTapAction(handleTeamsPositionTap)
    }
    
    func handleProjectsPositionTap() {
        router?.navigateToProjects()
    }
    
    func handleProfilePositionTap() {
        router?.navigateToProfile()
    }
    
    func handleTeamsPositionTap() {
        router?.navigateToTeams()
    }
}
