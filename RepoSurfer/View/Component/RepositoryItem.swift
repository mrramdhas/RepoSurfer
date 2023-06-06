//
//  RepositoryItem.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import SwiftUI

struct HomeItemView: View {
    var repository: Repository    
    var body: some View {
        VStack {
            
            HStack {
                // Owner avatar
                if let avatarURL = URL(string: (repository.owner?.avatarURL)!) { // TODO optionals handling
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

                // Owner name
                Text((repository.owner?.login)!)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    // Repository name
                    Text(repository.name!)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    // Repository description
                    Text(repository.description ?? "")
                        .font(.footnote)
                        .lineLimit(3)
                        .minimumScaleFactor(0.75)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
            }
            
            HStack(spacing: 15) {
                // Language
                if !(repository.language ?? "").isEmpty {
                    HStack(spacing: 2) {
                        Image(systemName: SFSymbols.pencilFill)
                        Text(repository.language!)
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

