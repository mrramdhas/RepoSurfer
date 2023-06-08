//
//  RepositoryItem.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import SwiftUI

struct RepoItemView: View {
    var repository: Repository    
    var body: some View {
        VStack {
            HStack {
                // Owner avatar
                let owner = repository.owner
                
                if let url = owner?.avatarURL {
                    if let avatarURL = URL(string: url) { // TODO optionals handling
                        AsyncImage(url: avatarURL) { image in
                            image
                                .resizable()
                        } placeholder: {
                            Image(systemName: SFSymbols.person)
                        }
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    }
                }
                
                if let login = owner?.login {
                    Text(login)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    if let name = repository.name {
                        Text(name)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
                Spacer()
            }
            
            HStack(spacing: 15) {
                if let language = repository.language {
                    HStack(spacing: 2) {
                        Image(systemName: SFSymbols.pencilFill)
                        Text(language)
                    }
                }
                
                Spacer()
            }
            .font(.footnote)
            .padding(.top, 1)
        }
        .padding(.horizontal)
    }
}

