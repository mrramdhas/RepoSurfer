//
//  HomeView.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import SwiftUI

struct RepositoryListView: View {
    
    @ObservedObject private var vm = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if vm.isLoading {
                    VStack(spacing: 10) {
                        Text("Loading")
                    }
                    .padding(.bottom, 90)
                } else {
                    if vm.repos.count > 0 {
                        List {
                            ForEach(vm.filteredItems, id: \.id) { item in
                                NavigationLink(destination: RepositoryDetailView(repo: item)) {
                                    HomeItemView(repository: item)
                                }
                            }
                        }
                        .searchable(text: $vm.search)
                    } else {
                        HStack {
                            Spacer()
                            Text("No Data Found")
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
    }
}
