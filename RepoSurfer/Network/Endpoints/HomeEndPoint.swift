//
//  HomeEndPoint.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation

enum HomeEndpoint {
    case repos(token: String, page: Int)
}

extension HomeEndpoint: EndPoint {
    
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    var path: String {
        switch self {
        case .repos(_, let page):
            return "user/repos?page=\(page)"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .repos(let token, _):
            return ["Authorization" : "Bearer \(token)", "Accept": HTTPContentType.applicationJSON]
        }
    }
}
