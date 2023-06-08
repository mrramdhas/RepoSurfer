//
//  RepositoryListViewModel.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation
import KeychainSwift

class RepositoryListViewModel: ObservableObject {
    
    private var service: RepoServiceDelegate
    
    @Published var repos: [Repository] {
        didSet {
            stopLoading()
        }
    }
    
    @Published var search: String = ""
    @Published var isLoading: Bool = false
    @Published var responseError: Error?
    
    var timer: Timer?
    var token: String?
    var dismissLoadingAfterSeconds: CGFloat = 1.0
    
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
    
    init(repoService: RepoServiceDelegate) {
        self.repos = []
        self.token = KeychainSwift().load(withKey: Keys.accessToken)
        service = repoService
    }
    
    /// This function will get the repos from server and populate the UI
    func getReposList() async {
        guard let token = token else { return }
            Task {
                do {
                    let result = try await service.getReposList(token: token)
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.repos.append(contentsOf: result)
                        self.isLoading = false
                    }
                } catch let error as RequestError {
                    switch error {
                    case .unauthorized:
                        DispatchQueue.main.async { [weak self] in
                            self?.isLoading = false
                            self?.responseError = error
                            print("Oops! Unauthorized")
                        }

                        break
                        
                    default:
                        DispatchQueue.main.async { [weak self] in
                            self?.responseError = error
                            print("Error occurred: \(error)")
                        }
                    }
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.isLoading = false
                    }
                } catch {
                    // Handle other errors
                    print("Error occurred: \(error)")
                    responseError = error
                    DispatchQueue.main.async { [weak self] in
                        self?.isLoading = false
                    }
                }
            }
    }
    
    /// This function will dismiss the loading after one second
    private func stopLoading() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: dismissLoadingAfterSeconds, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.isLoading = false
        }
    }
}
