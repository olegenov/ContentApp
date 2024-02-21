//
//  LoginViewConroller.swift
//  ContentApp
//
//  Created by Никита Китаев on 19.02.2024.
//

import UIKit

class LoginViewController: UIViewController {
    enum Constants {
        static let formTitleText: String = "login"
        static let formTopOffset: CGFloat = 250
        
        static let formSideMargin: CGFloat = 64
        static let sectionBottomOffset: CGFloat = 30
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTemplate()
        configureUI()
    }
    
    private let loginUsernameInputView: FormInput = FormInput(.username)
    private let loginPasswordInputView: FormInput = FormInput(.password)
    
    private func configureUI() {
        configureForm()
        configureSignupSwitch()
    }
    
    private func configureForm() {
        let loginForm = Form(Constants.formTitleText, formFields: [
            loginUsernameInputView,
            loginPasswordInputView
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
        
        let link = UILabel()
        link.text = "signup"
        link.font = UIFont.appFont(.regular)
        link.textColor = UIColor.AppColors.accentColor
        
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
    
    func handleSubmit() {
        guard let username = loginUsernameInputView.getData(), let password = loginPasswordInputView.getData() else {
            return
        }

        let user = User(username: username, password: password)
        print(user.password)
        print(user.username)
    }
}
