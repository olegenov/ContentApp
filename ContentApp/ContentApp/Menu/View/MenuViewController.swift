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

class MenuViewController: UIViewController, MenuDisplayLogic {
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
    var aboutMenuPosition = MenuPositionFactory.createMenuPosition(type: .about, active: false)
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
    
    private func configureUI() {
        configureMenu()
        configureActions()
    }
    
    private func configureMenu() {
        let menuFrame = CGRect(x: -Constants.menuWidth, y: 0, width: Constants.menuWidth, height: view.bounds.height)
        let menuView = UIView(frame: menuFrame)
        
        menuView.backgroundColor = UIColor.AppColors.white
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(menuView)
        
        menuItems.translatesAutoresizingMaskIntoConstraints = false
        menuItems.spacing = Constants.menuSpacing
        menuItems.axis = .vertical
        
        menuView.addSubview(menuItems)
        
        for item in [projectsMenuPosition, profileMenuPosition, aboutMenuPosition] {
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
        aboutMenuPosition.configurePositionTapAction(handleAboutPositionTap)
        profileMenuPosition.configurePositionTapAction(handleProfilePositionTap)
    }
    
    private func handleProjectsPositionTap() {
        router?.navigateToProjects()
    }
    
    private func handleAboutPositionTap() {
        router?.navigateToAboutPage()
    }
    
    private func handleProfilePositionTap() {
        router?.navigateToProfile()
    }
}
