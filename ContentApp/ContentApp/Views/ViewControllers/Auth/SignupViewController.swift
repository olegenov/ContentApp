//
//  SignupViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

protocol SignupDisplayLogic {
    func displayValidationError(_ error: String)
}

class SignupViewController: UIViewController, SignupDisplayLogic {
    enum Constants {
        static let formTitleText: String = "signup"
        static let formTopOffset: CGFloat = 180
        
        static let formSideMargin: CGFloat = 64
        static let sectionBottomOffset: CGFloat = 30
        
        static let sectionLinkTitle: String = "login"
        
        static let errorsGap: CGFloat = 8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTemplate()
        navigationItem.hidesBackButton = true
        configureUI()
    }
    
    var interactor: SignupBusinessLogic?
    var router: SignupRouterProtocol?
    
    private var form: Form = Form()
    private let firstNameInputView: FormInput = FormInputFactory.createFormInput(type: .firstName)
    private let surnameInputView: FormInput = FormInputFactory.createFormInput(type: .surname)
    private let usernameInputView: FormInput = FormInputFactory.createFormInput(type: .signupUsername)
    private let emailInputVIew: FormInput = FormInputFactory.createFormInput(type: .signupEmail)
    private let passwordInputView: FormInput = FormInputFactory.createFormInput(type: .signupPassword)
    private let repeatPasswordInputView: FormInput = FormInputFactory.createFormInput(type: .signupRepeatPassword)
    private var errorsStack: UIStackView = UIStackView()
    private let loginSection = UIStackView()
    
    init(interactor: SignupBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureForm()
        configureSignupSwitch()
        configureHidingKeyBoard()
        configureErrors()
    }
    
    private func configureForm() {
        form = Form(Constants.formTitleText, formFields: [
            firstNameInputView,
            surnameInputView,
            usernameInputView,
            emailInputVIew,
            passwordInputView,
            repeatPasswordInputView,
        ], submitText: Constants.formTitleText)
        
        form.configureSubmitButtonAction(handleSubmit)
        
        view.addSubview(form)
        form.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            form.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            form.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.formTopOffset),
            form.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.formSideMargin),
            form.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.formSideMargin),
        ])
    }
    
    private func configureSignupSwitch() {
        let section = loginSection
        
        section.axis = .horizontal
        section.spacing = 8
        
        let text = UILabel()
        text.text = "or"
        text.font = UIFont.appFont(.regular)
        text.textColor = UIColor.AppColors.textColor
        
        let link = ButtonFactory.createButton(type: .empty, title: Constants.sectionLinkTitle)
        link.setContentHuggingPriority(.required, for: .horizontal)
        link.addTarget(self, action: #selector(signupSwitchButtonTapped), for: .touchUpInside)
        
        section.addArrangedSubview(text)
        section.addArrangedSubview(link)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        link.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(section)
        section.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            section.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            section.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.sectionBottomOffset),
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
            errorsStack.bottomAnchor.constraint(equalTo: loginSection.topAnchor, constant: -Constants.errorsGap),
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
    
    @objc private func signupSwitchButtonTapped() {
        router?.navigateToLogin()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func handleSubmit() {
        errorsStack.clear()
        
        let formData = SignupFormData(
            firstname: firstNameInputView.getData(),
            surname: surnameInputView.getData(),
            username: usernameInputView.getData(),
            email: emailInputVIew.getData(),
            password: passwordInputView.getData(),
            repeatPassword: repeatPasswordInputView.getData()
        )
        
        interactor?.validateFormData(formData)
    }
    
    func displayValidationError(_ error: String) {
        let error = ErrorLabel(error)
        
        error.show()
        errorsStack.addArrangedSubview(error)
    }
}

