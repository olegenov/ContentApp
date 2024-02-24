//
//  SignupViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

class SignupViewController: UIViewController {
    enum Constants {
        static let formTitleText: String = "signup"
        static let formTopOffset: CGFloat = 180
        
        static let formSideMargin: CGFloat = 64
        static let sectionBottomOffset: CGFloat = 30
        
        static let sectionLinkTitle: String = "login"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTemplate()
        navigationItem.hidesBackButton = true
        configureUI()
    }
    
    private let firstNameInputView: FormInput = FormInputFactory.createFormInput(type: .firstName)
    private let surnameInputView: FormInput = FormInputFactory.createFormInput(type: .surname)
    private let usernameInputView: FormInput = FormInputFactory.createFormInput(type: .signupUsername)
    private let emailInputVIew: FormInput = FormInputFactory.createFormInput(type: .signupEmail)
    private let passwordInputView: FormInput = FormInputFactory.createFormInput(type: .signupPassword)
    private let repeatPasswordInputView: FormInput = FormInputFactory.createFormInput(type: .signupRepeatPassword)
    
    private func configureUI() {
        configureForm()
        configureSignupSwitch()
        configureHidingKeyBoard()
    }
    
    private func configureForm() {
        let loginForm = Form(Constants.formTitleText, formFields: [
            firstNameInputView,
            surnameInputView,
            usernameInputView,
            emailInputVIew,
            passwordInputView,
            repeatPasswordInputView,
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
    
    private func configureSignupSwitch() {
        let section = UIStackView()
        
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
    
    private func configureHidingKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func signupSwitchButtonTapped() {
        let loginViewController: UIViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: false)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func handleSubmit() {
        guard let username = usernameInputView.getData(), let password = passwordInputView.getData() else {
            return
        }
    }
}

