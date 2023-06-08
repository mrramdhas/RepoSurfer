//
//  Client.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation

struct Client {
    static let uri = "reposurfer://com.github.RepoSurfer"
    static let id = "775c8f45973b6f6da779"
    static let secret = "5ef440cc850982615afaa0a1a668846c2046926e"
}

struct Keys {
    static let accessToken = "accesstoken"
}

struct CallbackScheme {
    static let url = "reposurfer"
}

// MARK: - SF Symbols
struct SFSymbols {
    static let person       = "person.crop.circle"
    static let star         = "star"
    static let pencilFill   = "pencil.circle.fill"
    static let fork         = "tuningfork"
    static let lock         = "lock"
    static let unlock       = "lock.open"
}

let RESULT_PER_PAGE = 30
let LOADING = "Loading"
let NO_DATA_FOUND = "No Data"
