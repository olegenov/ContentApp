//
//  ProjectView.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.03.2024.
//

import UIKit

protocol ProjectDisplayLogic {
    func displayError(_ error: String)
    func displayPosts(_ posts: [Post])
    func displayTitle(_ title: String)
}

class ProjectViewController: BaseViewController, ProjectDisplayLogic {
    enum Constants {
        static let sideOffset: CGFloat = 16
        static let cardHeight: CGFloat = 176
        static let pageTitle: String = "project"
    }
    
    let projectId: Int
    var interactor: ProjectBusinessLogic?
    var router: ProjectRouterProtocol?
    private let cards = CardList(cardHeight: Constants.cardHeight)
    
    init(interactor: ProjectBusinessLogic, projectId: Int) {
        self.interactor = interactor
        self.projectId = projectId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.loadPosts(id: self.projectId)
    }
    
    internal override func configureUI() {
        configureTitle(title: Constants.pageTitle)
        configureCards()
    }
    
    internal override func configureNav() {
        let menuButton = ButtonFactory.createIconButton(type: .menu)
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        let projectsButton = ButtonFactory.createIconButton(type: .cards)
        projectsButton.addTarget(self, action: #selector(openProjects), for: .touchUpInside)
        projectsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let navBuilder = NavBuilder(nav: self.nav)
        navBuilder.addLeftButton(button: menuButton)
        navBuilder.addRightButton(button: projectsButton)
        navBuilder.addNameLabel()
        
        displayNav()
    }
    
    private func configureCards() {
        cards.configureAddCardTapAction(self.handleCreatingNewPost)
        cards.configureCardsTapAction(self.handleOpeningPost)
        cards.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cards)
        
        NSLayoutConstraint.activate([
            cards.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            cards.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            cards.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            cards.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func displayPosts(_ posts: [Post]) {
        var cardsData: [CardData] = []
        
        for post in posts {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy hh:mm"
            let publising = formatter.string(from: post.publishing)
            let deadline = formatter.string(from: post.deadline)
            
            var username = post.assign?.username
            
            if username == "" {
                username = "none"
            }
            
            cardsData.append(CardData(id: post.id, title: post.title, property: [
                (IconFactory.createIcon(type: .assign), username ?? "none"),
                (IconFactory.createIcon(type: .calendar), publising),
                (IconFactory.createIcon(type: .deadline), deadline),
            ]))
        }
        
        cards.updateData(cardsData)
    }
    
    func handleCreatingNewPost() {
        router?.navigateToPostCreation()
    }
    
    func handleOpeningPost(id: Int) {
        router?.navigateToPost(projectId: self.projectId, postId: id)
    }
    
    func displayTitle(_ title: String) {
        titleView.titleView.text = title
    }
    
    @objc func openMenu() {
        router?.navigateToMenu()
    }
    
    @objc func openProjects() {
        router?.navigateToProjects()
    }
}
