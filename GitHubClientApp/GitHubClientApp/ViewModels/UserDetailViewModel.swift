//
//  UserDetailViewModel.swift
//  GitHubClientApp
//
//  Created by Elvis Lin on 2025/7/23.
//

import Foundation

@MainActor
class UserDetailViewModel: ObservableObject {
    @Published var user: User?
    @Published var repositories: [Repository] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let username: String
    private let service: GitHubService

    init(username: String, service: GitHubService = GitHubService()) {
        self.username = username
        self.service = service
    }

    func fetchData() async {
        isLoading = true
        errorMessage = nil
        do {
            // Fetch user details and repositories in parallel
            async let fetchedUser = service.fetchUserDetails(username: username)
            async let fetchedRepos = service.fetchRepositories(username: username)

            user = try await fetchedUser
            repositories = try await fetchedRepos
        } catch {
            errorMessage = error.localizedDescription
            print("Error fetching user details or repositories: \(error)")
        }
        isLoading = false
    }
}
