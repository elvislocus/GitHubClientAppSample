//
//  UserListViewModel.swift
//  GitHubClientApp
//
//  Created by Elvis Lin on 2025/7/23.
//

import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let service: GitHubService

    init(service: GitHubService = GitHubService()) {
        self.service = service
    }

    func fetchUsers() async {
        isLoading = true
        errorMessage = nil
        do {
            users = try await service.fetchUsers()
        } catch {
            errorMessage = error.localizedDescription
            print("Error fetching users: \(error)")
        }
        isLoading = false
    }
}
