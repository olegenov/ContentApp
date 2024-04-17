//
//  FormInputFactory.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

class FormInputFactory {
    enum TextTypes {
        case surname
        case firstName
        case signupUsername
        case signupPassword
        case signupEmail
        case signupRepeatPassword
        case loginUsername
        case loginPassword
        case projectName
        case invitationUsername
    }
    
    enum SelectTypes {
        case team
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
    
    static func createFormTextInput(type: TextTypes) -> FormTextInput {
        let inputView: FormTextInput
        
        switch type {
        case .surname:
            inputView = FormTextInput(Constants.surnamePlaceHolder)
            
        case .firstName:
            inputView = FormTextInput(Constants.firstNamePlaceHolder)
            
        case .signupUsername:
            inputView = FormTextInput(Constants.usernamePlaceHolder)
            inputView.disableAutoCorrection()
            
        case .signupPassword:
            inputView = FormTextInput(Constants.passwordPlaceHolder)
            inputView.enableSecuring()
            inputView.disableAutoCorrection()
            
        case .signupEmail:
            inputView = FormTextInput(Constants.emailPlaceHolder)
            inputView.setKeyBoardType(.emailAddress)
            inputView.disableAutoCorrection()
            
        case .signupRepeatPassword:
            inputView = FormTextInput(Constants.repeatPasswordPlaceHolder)
            inputView.enableSecuring()
            inputView.disableAutoCorrection()
            
        case .loginUsername:
            inputView = FormTextInput(Constants.usernamePlaceHolder)
            inputView.disableAutoCorrection()
            
        case .loginPassword:
            inputView = FormTextInput(Constants.passwordPlaceHolder)
            inputView.enableSecuring()
            inputView.disableAutoCorrection()
            
        case .projectName:
            inputView = FormTextInput(Constants.projectNamePlaceHolder)
        
        case .invitationUsername:
            inputView = FormTextInput(Constants.usernamePlaceHolder)
            inputView.disableAutoCorrection()
        }
        
        return inputView
    }
    
    static func createFormSelectInput(type: SelectTypes, options: [FormSelectInputOption]) -> FormSelectInput {
        let inputView: FormSelectInput
        
        switch type {
        case .team:
            inputView = FormSelectInput(options)
            
        }
        
        return inputView
    }
}
