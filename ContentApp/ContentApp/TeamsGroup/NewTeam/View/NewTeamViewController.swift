//
//  NewTeamViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 11.04.2024.
//

import Foundation

import UIKit

protocol NewTeamDisplayLogic {
    func displayError(_ error: String)
    func handleSuccessCreation()
}

class NewTeamViewController: BaseViewController, NewTeamDisplayLogic {
    enum Constants {
        static let backButtonTopOffset: CGFloat = 80
        static let backButtonSideMargin: CGFloat = 16
        
        static let formTitleText: String = "new team"
        static let formTopOffset: CGFloat = 250
        
        static let formSideMargin: CGFloat = 64
        static let sectionBottomOffset: CGFloat = 30
        
        static let sectionLinkTitle: String = "create"
        
        static let errorsGap: CGFloat = 8
    }
    
    var interactor: NewTeamBusinessLogic?
    var router: NewTeamRouterProtocol?
    
    init(interactor: NewTeamBusinessLogic) {
        super.init(nibName: nil, bundle: nil)
        
        self.interactor = interactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let teamNameInputView: FormTextInput = FormInputFactory.createFormTextInput(type: .projectName)
    private let backButton: Button = ButtonFactory.createIconButton(type: .back)
    
    internal override func configureUI() {
        configureForm()
    }
    
    private func configureForm() {
        let newTeamForm = Form(Constants.formTitleText, formFields: [
            teamNameInputView,
        ], submitText: Constants.formTitleText)
        
        view.addSubview(newTeamForm)
        newTeamForm.translatesAutoresizingMaskIntoConstraints = false
        
        newTeamForm.configureSubmitButtonAction { [weak self] in
            self?.handleSubmit()
        }
        
        NSLayoutConstraint.activate([
            newTeamForm.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newTeamForm.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.formTopOffset),
            newTeamForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.formSideMargin),
            newTeamForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.formSideMargin),
        ])
    }
    
    internal override func configureNav() {
        backButton.addTarget(self, action: #selector(getBack), for: .touchUpInside)
        
        let navBuilder = NavBuilder(nav: self.nav)
        navBuilder.addLeftButton(button: backButton)
        
        displayNav()
    }
    
    func handleSubmit() {
        view.endEditing(true)
        errorsStack.clear()
        
        let formData = NewTeamFormData(
            name: teamNameInputView.getData()
        )
        
        interactor?.submitFormData(formData)
    }
    
    func handleSuccessCreation() {
        router?.navigateToTeams()
    }

    @objc func getBack() {
        router?.navigateToTeams()
    }
}
