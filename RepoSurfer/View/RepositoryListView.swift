//
//  RepositoryListView.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import SwiftUI

struct RepositoryListView: View {
    
    @ObservedObject private var vm = RepositoryListViewModel(repoService: RepoService())
    
    var body: some View {
        NavigationView {
            ZStack {
                if vm.isLoading {
                    VStack(spacing: 10) {
                        Text(LOADING)
                    }
                    .padding(.bottom, 90)
                } else {
                    if vm.repos.count > 0 {
                        List {
                            ForEach(vm.filteredItems, id: \.id) { item in
                                NavigationLink(destination: RepositoryDetailView(repo: item)) {
                                    RepoItemView(repository: item)
                                }
                            }
                        }
                        .searchable(text: $vm.search)
                    } else {
                        HStack {
                            Spacer()
                            Text(NO_DATA_FOUND)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
        .task {
            await vm.getReposList()
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
    }
}
