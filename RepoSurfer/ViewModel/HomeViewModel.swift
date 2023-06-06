//
//  HomeViewModel.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation


final class HomeViewModel: ObservableObject {
    
    private var service = HomeService()
    
    @Published private(set) var repos: [Repository] {
        didSet {
            stopLoading()
        }
    }
    @Published var search: String = ""
    
    @Published private(set) var isLoading: Bool = false
    
    private var page: Int = 1
    private var timer: Timer?
    private var token: String?
    private var dismissLoadingAfterSeconds: CGFloat = 1.0
    
    var filteredItems: [Repository] {
        if search.isEmpty {
            return repos
        } else {
            let keyword = search.lowercased()
            return repos.filter { item in
                item.name?.lowercased().contains(keyword) ?? false
            }
        }
    }
    
    init() {
        self.repos = []
        self.token = Keychain.shared.load(withKey: Keys.accessToken)
    }
    
    /// This function will get the repos from server and populate the UI
    func getReposList() async {
        guard let token = token else { return }
        
        // We should check the page here,
        // because we don't want to show the cat loading animation every time!
        if page < 2 {
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = true
            }
        }
        
        do {
            let result = try await service.getReposList(token: token, page: page)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.repos.append(contentsOf: result)
                
                // If there was more than 30,
                // we increase the page number for the next request
                if result.count == 30 { self.page += 1 }
            }
        } catch  {
            #if DEBUG
            print(error)
            #endif
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
            }
        }
    }
    
    /// This function will load more data based on number of page
    func loadMoreItems(item: Repository) {
        guard repos.count >= 30 else { return }
        
        let number = repos.count - 5
        guard item.id ?? 0 == repos[number].id else { return }
        
        Task { await getReposList() }
    }
    
    /// This function will dismiss the loading after one second
    private func stopLoading() {
        timer?.invalidate()
        
        // Adding one second delay here to let the animation perform and make it visiable
        // on fast Internet connections :D
        timer = Timer.scheduledTimer(withTimeInterval: dismissLoadingAfterSeconds, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.isLoading = false
        }
    }
}
