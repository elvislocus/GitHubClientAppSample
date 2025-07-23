//
//  APIError.swift
//  GitHubClientApp
//
//  Created by Elvis Lin on 2025/7/23.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    case rateLimitExceeded
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .invalidResponse: return "Invalid server response."
        case .decodingError(let error): return "Data decoding failed: \(error.localizedDescription)"
        case .networkError(let error): return "Network error: \(error.localizedDescription)"
        case .rateLimitExceeded: return "GitHub API rate limit exceeded, please try again later."
        case .unknown: return "An unknown error occurred."
        }
    }
}
