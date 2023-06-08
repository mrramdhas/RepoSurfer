//
//  Keychain.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation
import KeychainSwift

extension KeychainSwift {
    func save(_ string: String, forKey key: String) {
        self.set(string, forKey: key)
    }
    
    /// This function will load data from the keychain
    func load(withKey key: String) -> String? {
        return self.get(key)
    }
}
