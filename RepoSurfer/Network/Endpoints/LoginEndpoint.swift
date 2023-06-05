//
//  LoginEndpoint.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation

enum LoginEndPoint {
    case login(id: String, uri: String)
    case token(id: String, secret: String, code: String, uri: String)
}

extension LoginEndPoint: EndPoint {
    
    var baseURL: String {
        return "https://github.com/login/oauth/"
    }
    
    var path: String {
        switch self {
        case .login(let id, let uri):
            return "authorize?client_id=\(id)&redirect_uri=\(uri)"
        case .token(let id, let secret, let code, let uri):
            return "access_token?client_id=\(id)&client_secret=\(secret)&code=\(code)&redirect_uri=\(uri)"
        }
    }
    
    var header: [String: String] {
        return ["Accept":  HTTPContentType.applicationJSON]
    }

}
