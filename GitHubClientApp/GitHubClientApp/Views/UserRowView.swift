//
//  UserRowView.swift
//  GitHubClientApp
//
//  Created by Elvis Lin on 2025/7/23.
//

import SwiftUI

struct UserRowView: View {

    let user: User

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.avatarURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else if phase.error != nil {
                    Image(systemName: "person.circle.fill") // Placeholder for error
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                } else {
                    ProgressView() // Placeholder for loading
                        .frame(width: 50, height: 50)
                }
            }
            Text(user.login)
                .font(.headline)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
