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
}

class NewProjectViewController: UIViewController, NewProjectDisplayLogic {
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
    
    private let projectNameInputView: FormInput = FormInputFactory.createFormInput(type: .projectName)
    private let errorsStack: UIStackView = UIStackView()
    private let backButton: IconButton = IconButton(.back)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTemplate()
        
        navigationItem.hidesBackButton = true
        configureUI()
    }
    
    private func configureUI() {
        configureForm()
        configureHidingKeyBoard()
        configureErrors()
        configureBackButton()
    }
    
    private func configureForm() {
        let newProjectForm = Form(Constants.formTitleText, formFields: [
            projectNameInputView
        ], submitText: Constants.formTitleText)
        
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
    
    private func configureErrors() {
        errorsStack.axis = .vertical
        errorsStack.spacing = Constants.errorsGap
        errorsStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(errorsStack)
        
        NSLayoutConstraint.activate([
            errorsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.formSideMargin),
            errorsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.formSideMargin),
            errorsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.errorsGap),
        ])
    }
    
    private func configureBackButton() {
        backButton.addTarget(self, action: #selector(getBack), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.backButtonSideMargin),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.backButtonTopOffset),
        ])
    }
    
    func showError(errorText: String) {
        let errorLabel = ErrorLabel(errorText)
        errorLabel.show()

        errorsStack.addArrangedSubview(errorLabel)
    }
    
    private func configureHidingKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func handleSubmit() {
        errorsStack.clear()
        
        let formData = NewProjectFormData(
            name: projectNameInputView.getData()
        )
        
        interactor?.submitFormData(formData)
    }
    
    func displayError(_ error: String) {
        let errorLabel = ErrorLabel(error)
        
        errorLabel.show()
        errorsStack.addArrangedSubview(errorLabel)
    }
    
    func handleSuccessCreation() {
        router?.navigateToProjects()
    }
    
    @objc func getBack() {
        router?.navigateToProjects()
    }
}
