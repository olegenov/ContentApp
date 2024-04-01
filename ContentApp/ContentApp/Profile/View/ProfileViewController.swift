//
//  ProfileViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

protocol ProfileDisplayLogic {
    func displayError(_ error: String)
    func openSignupPage()
    func updateUserInfo(response: UserResponse)
}

class ProfileViewController: BaseViewController, ProfileDisplayLogic {
    enum Constants {
        static let backButtonTopOffset: CGFloat = 70
        static let backButtonSideMargin: CGFloat = 16
        
        static let navTopOffset: CGFloat = 70
        static let sideOffset: CGFloat = 16
        static let navHeight: CGFloat = 35
        static let title: String = "profile"
        
        static let errorsGap: CGFloat = 8
        static let errorsSideMargin: CGFloat = 16
        
        static let logoutButtonText: String = "logout"
    }
    
    var user: User = User(id: 0, username: "", firstname: "", surname: "", email: "")
    var interactor: ProfileBusinessLogic?
    var router: ProfileRouterProtocol?
    private let userCredentials: PageTitle  = PageTitle(Constants.title)
    private let menuButton: IconButton  = IconButton(.menu)
    private let backButton: IconButton = IconButton(.back)
    private let logoutButton: Button = ButtonFactory.createButton(type: .active, title: Constants.logoutButtonText)
    
    init(interactor: ProfileBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func configureUI() {
        configureTitle(title: Constants.title)
        configureUser()
        configureUserCredentials()
        configureLogoutButton()
    }
    
    internal override func configureNav() {
        backButton.addTarget(self, action: #selector(getBack), for: .touchUpInside)
        
        let navBuilder = NavBuilder(nav: nav)
        navBuilder.addLeftButton(button: backButton)
        
        displayNav()
    }

    private func configureUserCredentials() {
        userCredentials.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(userCredentials)
        
        NSLayoutConstraint.activate([
            userCredentials.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            userCredentials.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
        ])
    }
    
    private func configureLogoutButton() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(processLogout), for: .touchUpInside)
        
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
        ])
    }
    
    func updateTitle(username: String) {
        titleView.titleView.text = username + "'s profile"
    }
    
    func updateUserCredentials(firstname: String, surname: String) {
        userCredentials.titleView.text = firstname + " " + surname
    }
    
    private func configureUser() {
        interactor?.loadUser()
    }
    
    @objc func getBack() {
        router?.getBack()
    }
    
    @objc func processLogout() {
        interactor?.processLogout()
    }
    
    internal func openSignupPage() {
        router?.navigateToSignup()
    }
    
    func updateUserInfo(response: UserResponse) {
        self.user = User(id: response.id, username: response.username, firstname: response.firstname, surname: response.surname, email: response.email)
        
        updateTitle(username: user.username)
        updateUserCredentials(firstname: user.firstname, surname: user.surname)
    }
}
