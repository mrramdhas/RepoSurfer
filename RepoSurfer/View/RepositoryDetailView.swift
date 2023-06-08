//
//  RepositoryDetailView.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import SwiftUI

struct RepositoryDetailView: View {
    var repo: Repository

    var body: some View {
        List {
            Section(header: Text("Overview")) {
                RepositoryDetailHeaderView(repository: repo)
            }
            
            Section(header: Text("Description")) {
                Text(repo.description ?? "")
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }

            Section(header: Text("Last Commit at")) {
                Text(repo.pushedAt?.toReadableDateString() ?? "")
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
            
            Section(header: Text("Created at")) {
                Text(repo.createdAt?.toReadableDateString() ?? "")
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
        }
        .navigationTitle(repo.name?.uppercased() ?? "Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct RepositoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(repo: Repository(id: 2345, name: "realtor-react", owner: Owner(login: "mrramdhas", id: 47564242, avatarURL: "https://avatars.githubusercontent.com/u/47564242?v=4"), repoPrivate: true, description: "Building realtor clone using React.js & Tailwind CSS", language: "swift", forksCount: 23, stargazersCount: 4, size: 179, pushedAt: "2023-05-14T21:01:43Z", createdAt: "2023-05-14T21:01:43Z"))
    }
}
