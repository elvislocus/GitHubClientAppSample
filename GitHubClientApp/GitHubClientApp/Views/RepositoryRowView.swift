//
//  RepositoryRowView.swift
//  GitHubClientApp
//
//  Created by Elvis Lin on 2025/7/23.
//

import SwiftUI

struct RepositoryRowView: View {

    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            Text(repository.name)
                .font(.headline)
                .lineLimit(1)

            if let description = repository.description, !description.isEmpty {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            HStack {
                if let language = repository.language {
                    Text("Language: \(language)")
                        .font(.caption)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Capsule().fill(Color.blue.opacity(0.2)))
                        .cornerRadius(5)
                }

                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(.yellow)
                Text("\(repository.stargazersCount)")
                    .font(.caption)

                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
