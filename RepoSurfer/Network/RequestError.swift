//
//  RequestError.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation

public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case notFound
    case unauthorized(Data)
    case unexpectedStatusCode(Int)
    case unknown(String)
}
