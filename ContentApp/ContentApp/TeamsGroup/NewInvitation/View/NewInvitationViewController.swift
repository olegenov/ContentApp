//
//  NewInvitationViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import UIKit

protocol NewInvitationDisplayLogic {
    func displayError(_ error: String)
    func handleSuccessCreation()
}

class NewInvitationViewController: BaseViewController, NewInvitationDisplayLogic {
    enum Constants {
        static let backButtonTopOffset: CGFloat = 80
        static let backButtonSideMargin: CGFloat = 16
        
        static let formTitleText: String = "invite"
        static let formTopOffset: CGFloat = 250
        
        static let formSideMargin: CGFloat = 64
        static let sectionBottomOffset: CGFloat = 30
        
        static let sectionLinkTitle: String = "create invitation"
        
        static let errorsGap: CGFloat = 8
    }
    
    let teamId: Int
    var interactor: NewInvitationBusinessLogic?
    var router: NewInvitationRouterProtocol?
    
    init(teamId: Int, interactor: NewInvitationBusinessLogic) {
        self.teamId = teamId
        
        super.init(nibName: nil, bundle: nil)
        
        self.interactor = interactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let usernameInputView: FormTextInput = FormInputFactory.createFormTextInput(type: .invitationUsername)
    private let backButton: Button = ButtonFactory.createIconButton(type: .back)
    
    internal override func configureUI() {
        configureForm()
    }
    
    private func configureForm() {
        let newInvitationForm = Form(Constants.formTitleText, formFields: [
            usernameInputView,
        ], submitText: Constants.formTitleText)
        
        view.addSubview(newInvitationForm)
        newInvitationForm.translatesAutoresizingMaskIntoConstraints = false
        
        newInvitationForm.configureSubmitButtonAction { [weak self] in
            self?.handleSubmit()
        }
        
        NSLayoutConstraint.activate([
            newInvitationForm.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newInvitationForm.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.formTopOffset),
            newInvitationForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.formSideMargin),
            newInvitationForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.formSideMargin),
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
        
        let formData = NewInvitationFormData(
            teamId: teamId,
            username: usernameInputView.getData()
        )
        
        interactor?.submitFormData(formData)
    }
    
    func handleSuccessCreation() {
        router?.navigateToTeam()
    }
    
    @objc func getBack() {
        router?.navigateToTeam()
    }
}

