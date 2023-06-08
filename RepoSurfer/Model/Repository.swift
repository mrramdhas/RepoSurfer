//
//  Repository.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation


// MARK: - Repository Model
struct Repository: Codable {
    let id: Int?
    let name: String?
    let owner: Owner?
    let repoPrivate: Bool?
    let description: String?
    let language: String?
    let forksCount, stargazersCount, size: Int?
    let pushedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case repoPrivate = "private"
        case description
        case language
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
        case size
        case pushedAt = "pushed_at"
        case createdAt = "created_at"
    }
}


// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let id: Int?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
