//
//  LoginViewConroller.swift
//  ContentApp
//
//  Created by Никита Китаев on 19.02.2024.
//

import UIKit

protocol LoginDisplayLogic {
    func displayError(_ error: String)
    func handleSuccessLogin()
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    enum Constants {
        static let formTitleText: String = "login"
        static let formTopOffset: CGFloat = 250
        
        static let formSideMargin: CGFloat = 64
        static let sectionBottomOffset: CGFloat = 30
        
        static let sectionLinkTitle: String = "signup"
        
        static let errorsGap: CGFloat = 8
    }
    
    var interactor: LoginBusinessLogic?
    var router: LoginRouterProtocol?
    
    init(interactor: LoginBusinessLogic) {
        super.init(nibName: nil, bundle: nil)
        
        self.interactor = interactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let usernameInputView: FormInput = FormInputFactory.createFormInput(type: .loginUsername)
    private let passwordInputView: FormInput = FormInputFactory.createFormInput(type: .loginPassword)
    private var errorsStack: UIStackView = UIStackView()
    private let signupSection = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTemplate()
        configureNameLabel()
        navigationItem.hidesBackButton = true
        configureUI()
    }
    
    private func configureUI() {
        configureForm()
        configureSignupSwitch()
        configureHidingKeyBoard()
        configureErrors()
    }
    
    private func configureForm() {
        let loginForm = Form(Constants.formTitleText, formFields: [
            usernameInputView,
            passwordInputView
        ], submitText: Constants.formTitleText)
        
        view.addSubview(loginForm)
        loginForm.translatesAutoresizingMaskIntoConstraints = false
        
        loginForm.configureSubmitButtonAction { [weak self] in
            self?.handleSubmit()
        }
        
        NSLayoutConstraint.activate([
            loginForm.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginForm.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.formTopOffset),
            loginForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.formSideMargin),
            loginForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.formSideMargin),
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
            errorsStack.bottomAnchor.constraint(equalTo: signupSection.topAnchor, constant: -Constants.errorsGap),
        ])
    }
    
    private func configureSignupSwitch() {
        let section = signupSection
        
        section.axis = .horizontal
        section.spacing = 8
        
        let text = UILabel()
        text.text = "or"
        text.font = UIFont.appFont(.regular)
        text.textColor = UIColor.AppColors.textColor
        
        let link = ButtonFactory.createButton(type: .empty, title: Constants.sectionLinkTitle)
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
        router?.navigateToSignup()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func handleSubmit() {
        errorsStack.clear()
        
        let formData = LoginFormData(
            username: usernameInputView.getData(),
            password: passwordInputView.getData()
        )
        
        interactor?.submitFormData(formData)
    }
    
    func displayError(_ error: String) {
        let errorLabel = ErrorLabel(error)
        
        errorLabel.show()
        errorsStack.addArrangedSubview(errorLabel)
    }
    
    func handleSuccessLogin() {
        router?.navigateToProjects()
    }
}
