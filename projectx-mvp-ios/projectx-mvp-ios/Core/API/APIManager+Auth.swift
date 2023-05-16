//
//  APIManager+Login.swift
//  projectx-mvp-ios
//
//  Created by paulo.vazquez.acosta on 13/5/23.
//

import Foundation

extension APIManager {
    
    func loginAccount(username: String, password: String) async throws -> LoginModels.LoginResponseData {
        return try await fetch(.loginAccount(username: username, password: password),
                               responseType: LoginModels.LoginResponseData.self)
    }
}
