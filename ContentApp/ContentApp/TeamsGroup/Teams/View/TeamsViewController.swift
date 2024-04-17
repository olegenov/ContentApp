//
//  TeamsViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import UIKit

protocol TeamsDisplayLogic {
    func displayError(_ error: String)
    func displayTeams(_ teams: [TeamCard])
    func updateInvitationAmount(amount: Int)
}

class TeamsViewController: BaseViewController, TeamsDisplayLogic {
    enum Constants {
        static let sideOffset: CGFloat = 16
        static let title: String = "teams"
        static let cardHeight: CGFloat = 78
        static let guestLabel: String = "guest"
        static let ownerLabel: String = "owner"
    }
    
    var interactor: TeamsBusinessLogic?
    var router: TeamsRouterProtocol?
    private let cards = TeamList(cardHeight: Constants.cardHeight)
    
    init(interactor: TeamsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.loadTeams()
        interactor?.loadInvitations()
    }
    
    internal override func configureUI() {
        configureTitle(title: Constants.title)
        configureCards()
    }
    
    internal override func configureNav() {
        let menuButton = ButtonFactory.createIconButton(type: .menu)
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        let profileButton = ButtonFactory.createIconButton(type: .profile)
        profileButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
        let navBuilder = NavBuilder(nav: self.nav)
        navBuilder.addLeftButton(button: menuButton)
        navBuilder.addRightButton(button: profileButton)
        navBuilder.addNameLabel()
        
        displayNav()
    }
    
    private func configureCards() {
        cards.configureAddCardTapAction(self.handleCreatingNewTeam)
        cards.configureCardsTapAction(self.handleOpeningTeam)
        cards.configureInvitationsCardTapAction(self.openInvitations)
        
        cards.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cards)
        
        NSLayoutConstraint.activate([
            cards.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            cards.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            cards.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            cards.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func displayTeams(_ teams: [TeamCard]) {
        var cardsData: [CardData] = []
        
        cardsData.append(CardData(id: 0, title: "0", property: []))
        
        for team in teams {
            var creatorLabel = Constants.guestLabel
            
            if team.isCreator {
                creatorLabel = Constants.ownerLabel
            }
            
            cardsData.append(CardData(id: team.id, title: team.name, property: [
                (IconFactory.createIcon(type: .empty), creatorLabel)
            ]))
        }
        
        cards.updateData(cardsData)
    }
    
    func updateInvitationAmount(amount: Int) {
        cards.updateInvitationCardAmount(amount: amount)
    }
    
    func handleCreatingNewTeam() {
        router?.navigateToTeamCreation()
    }
    
    func handleOpeningTeam(teamId: Int) {
        router?.navigateToTeam(id: teamId)
    }
    
    @objc func openMenu() {
        router?.navigateToMenu()
    }
    
    @objc func openProfile() {
        router?.navigateToProfile()
    }
    
    @objc func openInvitations() {
        router?.navigateToInvitations()
    }
}

