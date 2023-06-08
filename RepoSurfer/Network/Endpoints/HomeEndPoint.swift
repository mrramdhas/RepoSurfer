//
//  RepoListEndpoint.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation

enum RepoListEndpoint {
    case repos(token: String)
}

extension RepoListEndpoint: EndPoint {
    
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    var path: String {
        switch self {
        case .repos(_):
            return "user/repos?page=1"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .repos(let token):
            return ["Authorization" : "Bearer \(token)", "Accept": HTTPContentType.applicationJSON]
        }
    }
}
