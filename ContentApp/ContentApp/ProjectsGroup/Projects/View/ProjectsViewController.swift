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

class ProjectsViewController: UIViewController, ProjectsDisplayLogic {
    enum Constants {
        static let navTopOffset: CGFloat = 70
        static let sideOffset: CGFloat = 16
        static let navHeight: CGFloat = 35
        static let title: String = "projects"
        static let titleTopOffset: CGFloat = 8
        
        static let errorsGap: CGFloat = 8
        static let errorsSideMargin: CGFloat = 16
    }
    
    var interactor: ProjectsBusinessLogic?
    var router: ProjectsRouterProtocol?
    private let nav = UIStackView()
    private let titleView = PageTitle(Constants.title)
    private let cards = CardList()
    private var errorsStack: UIStackView = UIStackView()
    private let menuButton = IconButton(.menu)
    private let profileButton = IconButton(.profile)
    
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
        configureNameLabel()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.loadProjects()
    }
    
    private func configureUI() {
        configureNav()
        configureTitle()
        configureCards()
        configureErrors()
    }
    
    private func configureNav() {
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        profileButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
        nav.addArrangedSubview(menuButton)
        nav.addArrangedSubview(profileButton)
        nav.distribution = .equalSpacing
        nav.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nav)
        
        NSLayoutConstraint.activate([
            nav.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.navTopOffset),
            nav.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            nav.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),

        ])
    }
    
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: nav.bottomAnchor, constant: Constants.titleTopOffset),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
        ])
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
    
    private func configureErrors() {
        errorsStack.axis = .vertical
        errorsStack.spacing = Constants.errorsGap
        errorsStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(errorsStack)
        
        NSLayoutConstraint.activate([
            errorsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.errorsSideMargin),
            errorsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.errorsSideMargin),
            errorsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.errorsGap),
        ])
    }
    
    internal func displayError(_ error: String) {
        let errorLabel = ErrorLabel(error)
        
        errorLabel.show()
        errorsStack.addArrangedSubview(errorLabel)
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(hideErrorLabel(_:)), userInfo: errorLabel, repeats: false)
    }
    
    @objc private func hideErrorLabel(_ timer: Timer) {
        guard let errorLabel = timer.userInfo as? ErrorLabel else { return }
        errorLabel.removeFromSuperview()
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

