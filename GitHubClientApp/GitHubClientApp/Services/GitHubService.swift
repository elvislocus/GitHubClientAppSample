//
//  Untitled.swift
//  GitHubClientApp
//
//  Created by Elvis Lin on 2025/7/23.
//

import Foundation

class GitHubService {

    private let accessToken: String? = {
        return Secrets.githubToken
    }()

    private let baseURL = "https://api.github.com"

    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: "\(baseURL)/users") else {
            throw APIError.invalidURL
        }
        let request = createRequest(url: url)
        return try await fetchData(request: request)
    }

    func fetchUserDetails(username: String) async throws -> User {
        guard let url = URL(string: "\(baseURL)/users/\(username)") else {
            throw APIError.invalidURL
        }
        let request = createRequest(url: url)
        return try await fetchData(request: request)
    }

    func fetchRepositories(username: String) async throws -> [Repository] {
        guard let url = URL(string: "\(baseURL)/users/\(username)/repos") else {
            throw APIError.invalidURL
        }
        let request = createRequest(url: url)
        let allRepos: [Repository] = try await fetchData(request: request)
        // Filter out forked repositories
        return allRepos.filter { !$0.fork }
    }
}

// MARK: - Private Methods
extension GitHubService {

    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        if let token = accessToken {
            request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        return request
    }

    private func fetchData<T: Codable>(request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            // Check Rate Limit
            if httpResponse.statusCode == 403, let xRateLimitRemaining = httpResponse.value(forHTTPHeaderField: "X-RateLimit-Remaining"), xRateLimitRemaining == "0" {
                throw APIError.rateLimitExceeded
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
                throw APIError.invalidResponse
            }

            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)

        } catch let decodingError as DecodingError {
            print("Decoding Error: \(decodingError)")
            throw APIError.decodingError(decodingError)
        } catch {
            throw APIError.networkError(error)
        }
    }
}
