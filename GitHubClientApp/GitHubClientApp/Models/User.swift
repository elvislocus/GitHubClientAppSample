//
//  User.swift
//  GitHubClientApp
//
//  Created by Elvis Lin on 2025/7/23.
//

struct User: Codable, Identifiable {
    let id: Int
    let login: String
    let avatarURL: String
    let htmlURL: String
    let name: String?
    let followers: Int?
    let following: Int?

    enum CodingKeys: String, CodingKey {
        case id, login, name, followers, following
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }
}
