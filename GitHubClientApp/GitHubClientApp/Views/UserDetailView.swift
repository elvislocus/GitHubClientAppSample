//
//  UserDetailView.swift
//  GitHubClientApp
//
//  Created by Elvis Lin on 2025/7/23.
//

import SwiftUI

struct UserDetailView: View {

    @StateObject private var viewModel: UserDetailViewModel

    // Pass username to initialize ViewModel
    init(username: String) {
        _viewModel = StateObject(wrappedValue: UserDetailViewModel(username: username))
    }

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.errorMessage {
                VStack {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                    Button("Retry") {
                        Task {
                            await viewModel.fetchData()
                        }
                    }
                }
            } else if let user = viewModel.user {
                contentView(user: user)
            }
        }
        .navigationTitle(viewModel.user?.login ?? "Loading...")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchData()
        }
    }

    func contentView(user: User) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    AsyncImage(url: URL(string: user.avatarURL)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            ProgressView()
                                .frame(width: 100, height: 100)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(user.login)
                            .font(.largeTitle)
                            .bold()
                        if let name = user.name {
                            Text(name)
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                        HStack {
                            if let followers = user.followers {
                                Text("Followers: \(followers)")
                            }
                            if let following = user.following {
                                Text("Following: \(following)")
                            }
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.horizontal)

                Divider()

                Text("Repositories")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal)

                if viewModel.repositories.isEmpty {
                    Text("No public repositories.")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                } else {
                    ForEach(viewModel.repositories) { repo in
                        NavigationLink(destination: WebView(urlString: repo.htmlURL)) {
                            RepositoryRowView(repository: repo)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
