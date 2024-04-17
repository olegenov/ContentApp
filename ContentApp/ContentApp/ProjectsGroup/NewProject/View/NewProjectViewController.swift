//
//  NewProjectViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

protocol NewProjectDisplayLogic {
    func displayError(_ error: String)
    func handleSuccessCreation()
    func updateTeams(teams: [Team])
}

class NewProjectViewController: BaseViewController, NewProjectDisplayLogic {
    enum Constants {
        static let backButtonTopOffset: CGFloat = 80
        static let backButtonSideMargin: CGFloat = 16
        
        static let formTitleText: String = "new project"
        static let formTopOffset: CGFloat = 250
        
        static let formSideMargin: CGFloat = 64
        static let sectionBottomOffset: CGFloat = 30
        
        static let sectionLinkTitle: String = "create"
        
        static let errorsGap: CGFloat = 8
    }
    
    var interactor: NewProjectBusinessLogic?
    var router: NewProjectRouterProtocol?
    
    init(interactor: NewProjectBusinessLogic) {
        super.init(nibName: nil, bundle: nil)
        
        self.interactor = interactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let projectNameInputView: FormTextInput = FormInputFactory.createFormTextInput(type: .projectName)
    private let teamInputView: FormSelectInput = FormInputFactory.createFormSelectInput(type: .team, options: [
        FormSelectInputOption(id: 0, name: "new team", editable: true),
    ])
    private let backButton: Button = ButtonFactory.createIconButton(type: .back)
    
    internal override func configureUI() {
        configureForm()
    }
    
    private func configureForm() {
        let newProjectForm = Form(Constants.formTitleText, formFields: [
            projectNameInputView,
            teamInputView,
        ], submitText: Constants.formTitleText)
        
        interactor?.loadTeams()
        
        view.addSubview(newProjectForm)
        newProjectForm.translatesAutoresizingMaskIntoConstraints = false
        
        newProjectForm.configureSubmitButtonAction { [weak self] in
            self?.handleSubmit()
        }
        
        NSLayoutConstraint.activate([
            newProjectForm.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newProjectForm.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.formTopOffset),
            newProjectForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.formSideMargin),
            newProjectForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.formSideMargin),
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
        
        let formData = NewProjectFormData(
            name: projectNameInputView.getData(),
            team: teamInputView.getData()
        )
        
        interactor?.submitFormData(formData)
    }
    
    func handleSuccessCreation() {
        router?.navigateToProjects()
    }
    
    func updateTeams(teams: [Team]) {
        var options: [FormSelectInputOption] = []
        
        for team in teams {
            options.append(FormSelectInputOption(id: team.id, name: team.name, editable: false))
        }
        
        teamInputView.updateOptions(newOptions: options)
    }
    
    @objc func getBack() {
        router?.navigateToProjects()
    }
}
