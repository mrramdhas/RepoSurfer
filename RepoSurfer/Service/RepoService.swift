//
//  RepoService.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation

protocol RepoServiceDelegate {
    func getReposList(token: String) async throws -> [Repository]
}

class RepoService: HTTPClient, RepoServiceDelegate {
    init() {}

    func getReposList(token: String) async throws -> [Repository]  {
        let response = try await sendRequest(endpoint: RepoListEndpoint.repos(token: token), httpMethod: .get, responseModel: [Repository].self)
        return response
    }
}
