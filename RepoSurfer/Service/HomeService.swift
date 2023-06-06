//
//  HomeService.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation

protocol HomeServiceDelegate {
    func getReposList(token: String, page: Int) async throws -> [Repository]
}

struct HomeService: HTTPClient, HomeServiceDelegate {
    func getReposList(token: String, page: Int) async throws -> [Repository]  {
        let response = try await sendRequest(endpoint: HomeEndpoint.repos(token: token, page: page), httpMethod: .get, responseModel: [Repository].self)
        
        return response
    }
}
