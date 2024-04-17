//
//  TeamViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import Foundation

import UIKit

protocol TeamDisplayLogic {
    func displayError(_ error: String)
    func displayUsers(_ users: [User], creatorId: Int)
    func displayTitle(_ title: String)
}

class TeamViewController: BaseViewController, TeamDisplayLogic {
    enum Constants {
        static let sideOffset: CGFloat = 16
        static let cardHeight: CGFloat = 64
        static let pageTitle: String = "Team"
    }
    
    let teamId: Int
    var interactor: TeamBusinessLogic?
    var router: TeamRouterProtocol?
    private let cards = UserList(cardHeight: Constants.cardHeight)
    
    init(interactor: TeamBusinessLogic, teamId: Int) {
        self.interactor = interactor
        self.teamId = teamId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.loadUsers(id: self.teamId)
    }
    
    internal override func configureUI() {
        configureTitle(title: Constants.pageTitle)
        configureCards()
    }
    
    internal override func configureNav() {
        let menuButton = ButtonFactory.createIconButton(type: .menu)
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        let teamsButton = ButtonFactory.createIconButton(type: .cards)
        teamsButton.addTarget(self, action: #selector(openTeams), for: .touchUpInside)
        teamsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let navBuilder = NavBuilder(nav: self.nav)
        navBuilder.addLeftButton(button: menuButton)
        navBuilder.addRightButton(button: teamsButton)
        navBuilder.addNameLabel()
        
        displayNav()
    }
    
    private func configureCards() {
        cards.configureAddCardTapAction(self.handleCreatingNewInvitation)
        cards.translatesAutoresizingMaskIntoConstraints = false
        cards.configureInviteAction(action: handleCreatingNewInvitation)
        view.addSubview(cards)
        
        NSLayoutConstraint.activate([
            cards.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            cards.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            cards.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            cards.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func displayUsers(_ users: [User], creatorId: Int) {
        var cardsData: [CardData] = []
        
        for user in users {
            var status = ""
            
            if user.id == creatorId {
                status = "owner"
            }
            
            cardsData.append(CardData(id: user.id, title: user.username, property: [
                (IconFactory.createIcon(type: .empty), status),
            ]))
        }
        
        cards.updateData(cardsData)
    }
    
    func handleCreatingNewInvitation() {
        router?.navigateToInvitationCreation(teamId: teamId)
    }
    
    func displayTitle(_ title: String) {
        titleView.titleView.text = title
    }
    
    @objc func openMenu() {
        router?.navigateToMenu()
    }
    
    @objc func openTeams() {
        router?.navigateToTeams()
    }
}
