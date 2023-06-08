//
//  RepositoryListTestCase.swift
//  RepoSurferTests
//
//  Created by Ramdhas on 2023-06-07.
//

import XCTest
import KeychainSwift
@testable import RepoSurfer

final class RepositoryListTestCase: XCTestCase {
    
    var viewModel: RepositoryListViewModel!
    var repoService: RepoServiceDelegate!

    override func setUp() {
        super.setUp()
        repoService = RepoService()
        viewModel = RepositoryListViewModel(repoService: RepoService())
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    
    func testRepoListAPI() async {
        // Given
        let expectation = XCTestExpectation(description: "API call expectation")
        let token = KeychainSwift().load(withKey: Keys.accessToken)
        
        // When
        do {
            let repos = try await repoService.getReposList(token: token ?? "")
            
            // Then
            XCTAssertFalse(repos.isEmpty, "API response should contain repositories")
            expectation.fulfill()
        } catch {
            XCTFail("API call failed with error: \(error)")
        }
        
        // Wait for the expectation to be fulfilled with a timeout
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetReposList_InvalidToken() async {
            // Given
            let token = ""
            let expectation = XCTestExpectation(description: "Get repositories list with invalid token")
            
            // When
            do {
                let response = try await repoService.getReposList(token: token)
                print("response", response)
                // Then
                XCTFail("Request should have thrown an error for invalid token")
            } catch RequestError.unauthorized {
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error occurred: \(error)")
            }
            
            wait(for: [expectation], timeout: 20.0)
        }

    
    // Test the filteredItems property
    func testFilteredItems() {
        let repos = [
            Repository(id: 1, name: "Repo 1", owner: nil, repoPrivate: false, description: "Test repo", language: "Swift", forksCount: 10, stargazersCount: 5, size: 1024, pushedAt: nil, createdAt: nil),
            Repository(id: 2, name: "Repo 2", owner: nil, repoPrivate: false, description: "Another repo", language: "Java", forksCount: 5, stargazersCount: 3, size: 512, pushedAt: nil, createdAt: nil)
        ]
        viewModel.repos = repos
        
        viewModel.search = "repo"
        
        let filteredItems = viewModel.filteredItems
        XCTAssertEqual(filteredItems.count, 2)
        
        viewModel.search = "test"
        XCTAssertEqual(filteredItems[0].name, "Repo 1")
        
        viewModel.search = ""
        XCTAssertEqual(filteredItems.count, 2)
    }
    
}
