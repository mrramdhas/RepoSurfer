//
//  EndPoint.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation

public protocol EndPoint {
    var baseURL: String {get}
    var path: String {get}
    var header: [String: String] {get}
}
