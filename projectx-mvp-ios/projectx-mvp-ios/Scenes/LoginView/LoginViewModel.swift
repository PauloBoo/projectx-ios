//
//  LoginViewModel.swift
//  projectx-mvp-ios
//
//  Created by paulo.vazquez.acosta on 13/5/23.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    enum ViewState {
        case normal
        case loading
        case success
        case noUser
        case errorServer
        case noNetworkError
    }
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var selectedUser: String = ""
    @Published var showPassword: Bool = false
    @Published var viewState: ViewState = .normal
    @Published var loginResponseData: LoginModels.LoginResponseData?
    
    let welcomeTitleStringKey: LocalizedStringKey = "Login.Welcome.Title"
    let usernameTextFieldStringKey: LocalizedStringKey = "Login.UsernameField.Title"
    let passwordTextFieldsStringKey: LocalizedStringKey = "Login.PasswordField.Title"
    let loginButtonStringKey: LocalizedStringKey = "Login.LoginButton.Title"
    let forgotPasswordButtonStringKey: LocalizedStringKey = "Login.ForgotPasswordTextButton.Title"
    let createAccountuttonStringKey: LocalizedStringKey = "Login.CreateAccountTextButtton.Title"
    
    let userToEmailMap: [String: String] = [
        "EcoBuilding S.A.S": "info@ecobuildingsas.com.ar",
        "Administración": "admin@simplecheck.es",
        "Viejobueno": "info@viejobueno.ar"
    ]
    
    var isTextFieldDisabled: Bool {
        viewState == .loading || viewState == .success
    }
    
    var isLoginButtonIsDisabled: Bool {
        username.count < 4 || password.count < 4
    }
    
    func login() {
        
        guard !isLoginButtonIsDisabled else { return }
        
        viewState = .loading
        
        Task {
            do {
                let loginResponseData = try await apiManager.loginAccount(username: username, password: password)
                DispatchQueue.main.async {
                    
                    self.loginResponseData = loginResponseData
                    self.viewState = .success
                }
            } catch {
                DispatchQueue.main.async {
                    self.loginResponseData = nil
                    switch error {
                    case APIError.serverError:
                        self.viewState = .errorServer
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    case APIError.noNetwork:
                        self.viewState = .noNetworkError
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    case APIError.noData:
                        self.viewState = .noUser
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    default:
                        self.viewState = .normal
                    }
                }
            }
        }
    }
    
    func updateUserEmail() {
        if let email = userToEmailMap[selectedUser] {
            username = email
        } else {
            username = ""
        }
    }
}
