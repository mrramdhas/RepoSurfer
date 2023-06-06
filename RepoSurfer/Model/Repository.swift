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
    let forksCount, stargazersCount, watchersCount, size: Int?
    let defaultBranch: String?
    let openIssuesCount: Int?
    let visibility: String?
    let pushedAt, createdAt, updatedAt: String?
    let forks, openIssues, watchers: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case repoPrivate = "private"
        case description
        case language
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case size
        case defaultBranch = "default_branch"
        case openIssuesCount = "open_issues_count"
        case visibility
        case pushedAt = "pushed_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case forks
        case openIssues = "open_issues"
        case watchers
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
