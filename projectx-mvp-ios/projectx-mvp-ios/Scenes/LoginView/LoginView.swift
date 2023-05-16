//
//  LoginView.swift
//  projectx-mvp-ios
//
//  Created by paulo.vazquez.acosta on 13/5/23.
//

import SwiftUI

struct LoginScreen: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    let users = ["EcoBuilding S.A.S", "Administración", "Viejobueno"]
    
    var body: some View {
        VStack {
            
            Picker("Usuarios", selection: $viewModel.selectedUser) {
                ForEach(users, id: \.self) { user in
                    Text(user)
                }
            }
            .pickerStyle(DefaultPickerStyle())
            .padding(.top, 20)
            .onChange(of: viewModel.selectedUser) { _ in
                viewModel.updateUserEmail()
            }
            
            Spacer()
            
            AppIcon()
                .frame(width: UIScreen.main.bounds.width / 2)
            
            Text(viewModel.welcomeTitleStringKey)
            
            VStack {
                HStack {
                    TextField(
                        viewModel.usernameTextFieldStringKey,
                        text: $viewModel.username
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.top, 20)
                    
                    if !viewModel.username.isEmpty {
                        Button(action: {
                            viewModel.username = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }.disabled(viewModel.isTextFieldDisabled)
                
                Divider()
                
                HStack {
                    switch viewModel.showPassword {
                    case true:
                        TextField(
                            viewModel.passwordTextFieldsStringKey,
                            text: $viewModel.password
                        ).autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.top, 20)
                    case false:
                        SecureField(
                            viewModel.passwordTextFieldsStringKey,
                            text: $viewModel.password
                        ).autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.top, 20)
                    }
                    
                    
                    Button(action: {
                        viewModel.showPassword.toggle()
                    }) {
                        Image(systemName: viewModel.showPassword ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                }.disabled(viewModel.isTextFieldDisabled)
                
                Divider()
            }
            
            HStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .black))
                case .success:
                    if let loginResponseData = viewModel.loginResponseData {
                        ConstructorMainView()
                    }
                case .normal, .noUser, .errorServer, .noNetworkError:
                    Button(
                        action: viewModel.login,
                        label: {
                            Text(viewModel.loginButtonStringKey)
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .frame(maxWidth: .infinity, maxHeight: 30)
                                .foregroundColor(Color.white)
                                .background(Color.yellow)
                                .cornerRadius(100)
                        }
                    )
                    .opacity(viewModel.isLoginButtonIsDisabled ? 0.5 : 1.0)
                    .disabled(viewModel.isLoginButtonIsDisabled)
                }
            }
            .padding(.bottom, 30)
            

            
            Button(action: {}) {
                Text(viewModel.forgotPasswordButtonStringKey)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
            }

            Button(action: {}) {
                Text(viewModel.createAccountuttonStringKey)
                    .foregroundColor(.gray)
                    .padding(.top, 4)
            }
            
            Spacer()
        }
        .padding(30)
    }
}

struct AppIcon: View {
    var body: some View {
        if let iconFileName = Bundle.main.iconFileName,
           let uiImage = UIImage(named: iconFileName) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Color.red
        }
    }
}

extension Bundle {
    var iconFileName: String? {
        guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.last
        else { return nil }
        return iconFileName
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
