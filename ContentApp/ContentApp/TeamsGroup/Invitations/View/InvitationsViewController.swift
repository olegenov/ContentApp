//
//  InvitationsViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.04.2024.
//

import UIKit

protocol InvitationsDisplayLogic {
    func displayError(_ error: String)
    func displayInvitations(_ invitations: [Invitation])
}

class InvitationsViewController: BaseViewController, InvitationsDisplayLogic {
    enum Constants {
        static let sideOffset: CGFloat = 16
        static let title: String = "team invitations"
        static let cardHeight: CGFloat = 64
    }
    
    var interactor: InvitationsBusinessLogic?
    var router: InvitationsRouterProtocol?
    private let cards = InvitationsList(cardHeight: Constants.cardHeight)
    
    init(interactor: InvitationsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.loadInvitations()
    }
    
    internal override func configureUI() {
        configureTitle(title: Constants.title)
        configureCards()
    }
    
    internal override func configureNav() {
        let teamsButton = ButtonFactory.createIconButton(type: .back)
        teamsButton.addTarget(self, action: #selector(openTeams), for: .touchUpInside)
        teamsButton.translatesAutoresizingMaskIntoConstraints = false

        let navBuilder = NavBuilder(nav: self.nav)
        navBuilder.addLeftButton(button: teamsButton)
        
        displayNav()
    }
    
    private func configureCards() {
        cards.translatesAutoresizingMaskIntoConstraints = false
        cards.configureAcceptAction(action: self.handleAcceptingInvitation)
        cards.configureRejectAction(action: self.handleRejectingInvitation)
        
        view.addSubview(cards)
        
        NSLayoutConstraint.activate([
            cards.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            cards.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            cards.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            cards.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func displayInvitations(_ invitations: [Invitation]) {
        var cardsData: [CardData] = []
        
        for invitation in invitations {
            cardsData.append(CardData(id: invitation.id, title: invitation.teamName, property: [
                (IconFactory.createIcon(type: .empty), invitation.senderUsername)
            ]))
        }
        
        cards.updateData(cardsData)
    }
    
    @objc func openTeams() {
        router?.navigateToTeams()
    }
    
    func handleAcceptingInvitation(_ id: Int) {
        self.interactor?.acceptInvitation(id)
    }
    
    func handleRejectingInvitation(_ id: Int) {
        self.interactor?.rejectInvitation(id)
    }
}
