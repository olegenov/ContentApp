//
//  RootViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import UIKit

protocol RootDisplayLogic {
    func openSignupPage()
    func openProjectsPage()
    func displayError(_ error: String)
}

class RootViewController: UIViewController, RootDisplayLogic {
    enum Constants {
        static let errorsGap: CGFloat = 8
        static let errorsSideMargin: CGFloat = 16
    }
    
    var router: RootRouterProtocol?
    var interactor: RootBusinessLogic?
    private var errorsStack: UIStackView = UIStackView()
    
    init(interactor: RootBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkToken()
    }
    
    private func configureUI() {
        configureErrors()
        view.backgroundColor = UIColor.AppColors.white
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
            errorsStack.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -Constants.errorsGap),
        ])
    }

    private func checkToken() {
        if !TokenManager.shared.hasToken() {
            router?.navigateToSignup()
        }
        
        interactor?.checkToken()
    }
    
    internal func openSignupPage() {
        router?.navigateToSignup()
    }
    
    internal func openProjectsPage() {
        router?.navigateToProjects()
    }
    
    internal func displayError(_ error: String) {
        let errorLabel = ErrorLabel(error)
        
        errorLabel.show()
        errorsStack.addArrangedSubview(errorLabel)
    }
}
