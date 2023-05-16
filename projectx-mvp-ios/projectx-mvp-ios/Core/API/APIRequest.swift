//
//  APIRequest.swift
//  Cajut
//
//  Created by Jacobo Rodriguez on 2/5/22.
//

import Foundation

enum APIRequest {
    case loginAccount(username: String, password: String)
    case getObrasbyConstructor(id: String)
}

extension APIRequest {

    //     var baseURL: URL { URL(string: "https://api.simplecheck.es/v1/")! }
    var baseURL: URL { URL(string: "https://run.mocky.io/v3/")! }

    var path: String {
        switch self {
        case .loginAccount:
            // return "auth/login"
            return "049a196c-6f13-4633-a2a9-2062ed9416b2"
        case .getObrasbyConstructor:
            return "ec172edf-d6eb-40b5-aad7-40ed489e614c"
        }
    }

    var url: URL { baseURL.appendingPathComponent(path) }

    var method: APIMethod {
        switch self {
        case .loginAccount:
            return .post
        case .getObrasbyConstructor:
            return .get
        }
    }

    var bodyParams: [String: Any] {
        switch self {
        case .loginAccount(let username, let password):
            return ["email": username, "password": password]
        case .getObrasbyConstructor(id: let id):
            return ["id_constructor": id]
        }
    }
}
