//
//  RepoSurferApp.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import SwiftUI
import KeychainSwift

@main
struct RepoSurferApp: App {
    
    private var token: String?
    
    init() {
        self.token = KeychainSwift().load(withKey: Keys.accessToken)
    }
    
    var body: some Scene {
        WindowGroup {
            if token != nil {
                RepositoryListView()
            } else {
                LoginView()
            }
        }
    }
}
