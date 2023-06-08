//
//  LoginService.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation

protocol LoginServiceDelegate {
    func getAccessToken(id: String, secret: String, code: String, uri: String, httpMethod: HTTPMethod) async throws -> Token
}

struct LoginService: HTTPClient, LoginServiceDelegate {
    
    func getAccessToken(id: String, secret: String, code: String, uri: String, httpMethod: HTTPMethod) async throws -> Token {
        let response = try await sendRequest(endpoint: LoginEndPoint.token(id: id, secret: secret, code: code, uri: uri), httpMethod: httpMethod, responseModel: Token.self)
        
        return .init(accessToken: response.accessToken, scope: response.scope, tokenType: response.tokenType)
    }
}
