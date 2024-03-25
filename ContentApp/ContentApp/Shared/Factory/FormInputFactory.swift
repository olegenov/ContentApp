//
//  FormInputFactory.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

class FormInputFactory {
    enum Types {
        case surname
        case firstName
        case signupUsername
        case signupPassword
        case signupEmail
        case signupRepeatPassword
        case loginUsername
        case loginPassword
        case projectName
    }
    
    enum Constants {
        static var firstNamePlaceHolder: String = "first name"
        static var surnamePlaceHolder: String = "surname"
        static var usernamePlaceHolder: String = "username"
        static var passwordPlaceHolder: String = "password"
        static var repeatPasswordPlaceHolder: String = "repeat password"
        static var emailPlaceHolder: String = "email"
        static var projectNamePlaceHolder: String = "name"
    }
    
    static func createFormInput(type: Types) -> FormInput {
        let inputView: FormInput
        
        switch type {
        case .surname:
            inputView = FormInput(Constants.surnamePlaceHolder)
        case .firstName:
            inputView = FormInput(Constants.firstNamePlaceHolder)
        case .signupUsername:
            inputView = FormInput(Constants.usernamePlaceHolder)
            inputView.disableAutoCorrection()
        case .signupPassword:
            inputView = FormInput(Constants.passwordPlaceHolder)
            inputView.enableSecuring()
            inputView.disableAutoCorrection()
        case .signupEmail:
            inputView = FormInput(Constants.emailPlaceHolder)
            inputView.setKeyBoardType(.emailAddress)
            inputView.disableAutoCorrection()
        case .signupRepeatPassword:
            inputView = FormInput(Constants.repeatPasswordPlaceHolder)
            inputView.enableSecuring()
            inputView.disableAutoCorrection()
        case .loginUsername:
            inputView = FormInput(Constants.usernamePlaceHolder)
            inputView.disableAutoCorrection()
        case .loginPassword:
            inputView = FormInput(Constants.passwordPlaceHolder)
            inputView.enableSecuring()
            inputView.disableAutoCorrection()
        case .projectName:
            inputView = FormInput(Constants.projectNamePlaceHolder)
        }
        
        return inputView
    }
}
