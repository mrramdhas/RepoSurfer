//
//  RepositoryDetailHeaderView.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-06.
//

import SwiftUI
import Foundation

struct RepositoryDetailHeaderView: View {
    var repository: Repository
    
    var body: some View {
        VStack {
            HStack {
                if let avatarURL = URL(string: repository.owner?.avatarURL ?? "") {
                    AsyncImage(url: avatarURL) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Image(systemName: SFSymbols.person)
                    }
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                }
                
                Text(repository.owner?.login ?? "")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
            HStack {
                Text(repository.name ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                Spacer()
            }
            
            HStack(spacing: 15) {
                
                if let isPrivate = repository.repoPrivate {
                    HStack(spacing: 2) {
                        Image(systemName: isPrivate ? SFSymbols.lock : SFSymbols.unlock)
                        Text( isPrivate ? "Private" : "Public")
                    }
                    .font(.footnote)
                    .fontWeight(.semibold)
                }
                HStack(spacing: 5) {
                    Image(systemName: SFSymbols.star)
                    
                    HStack(spacing: 2) {
                        Text(String(repository.stargazersCount ?? 0))
                            .fontWeight(.semibold)
                        
                        Text(repository.stargazersCount ?? 0 == 1 ? "star" : "stars")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
                .fontWeight(.semibold)
                
                HStack(spacing: 4) {
                    Image(systemName: SFSymbols.fork)
                    
                    HStack(spacing: 2) {
                        Text(String(repository.forksCount ?? 0))
                        
                        Text(repository.forksCount ?? 0 == 1 ? "fork" : "forks")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
                .fontWeight(.semibold)
                
                Spacer()
            }
            .font(.footnote)
            .padding(.top, 1)
        }
    }
}
