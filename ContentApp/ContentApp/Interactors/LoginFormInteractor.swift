//
//  LoginFormInteractor.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.03.2024.
//

import Foundation

protocol LoginBusinessLogic {
    func submitFormData(_ formData: LoginFormData)
}

class LoginFormInteractor: LoginBusinessLogic {
    var presenter: LoginPresentationLogic?
    var apiService: APIServiceProtocol = APIService()
    
    init(presenter: LoginPresentationLogic) {
        self.presenter = presenter
    }
    
    func submitFormData(_ formData: LoginFormData) {
        
    }
}
