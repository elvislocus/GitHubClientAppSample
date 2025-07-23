//
//  UserListView.swift
//  GitHubClientApp
//
//  Created by Elvis Lin on 2025/7/23.
//

import SwiftUI

struct UserListView: View {

    @StateObject private var viewModel = UserListViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                        Button("Retry") {
                            Task {
                                await viewModel.fetchUsers()
                            }
                        }
                    }
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(destination: UserDetailView(username: user.login)) {
                            UserRowView(user: user)
                        }
                    }
                }
            }
            .navigationTitle("GitHub Users")
            .task { // Automatically trigger data loading when the View appears
                await viewModel.fetchUsers()
            }
            .refreshable { // Pull to refresh
                await viewModel.fetchUsers()
            }
        }
    }
}
