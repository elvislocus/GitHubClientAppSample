//
//  Secrets.swift
//  GitHubClientApp
//
//  Created by Elvis Lin on 2025/7/23.
//

enum Secrets {
    // Please store your GitHub Personal Access Token here, or a better way is
    // to read it from environment variables/configuration files. For simplicity
    // of the sample, it's placed directly here, but in real applications,
    // hardcoding should be avoided. Before packaging the application, ensure this
    // token is not directly compiled into it, especially for publicly released
    // applications.
    //
    // TODO: 
    // Recommended to read from environment variables or project settings, e.g.:
    // ProcessInfo.processInfo.environment["GITHUB_ACCESS_TOKEN"]
    // Or read from Info.plist or other configuration files
    static let githubToken = "YOUR_GITHUB_PERSONAL_ACCESS_TOKEN"
}
