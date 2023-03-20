//
//  ApiService.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import Foundation

enum ApiError: LocalizedError {
    case serverError
    case noData
    case urlError
    
    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Error: Server status 200"
        case .noData:
            return "Error: No Data from server"
        case .urlError:
            return "Error: Incorrect URL"
        }
    }
}

enum ApiPath: RawRepresentable, API {
    
    static let baseUrl = URL(string: "https://api.github.com")!
    
    case users
    case userRepo(id: String)
    
    var rawValue: String {
        switch self {
        case .users: return "users"
        case .userRepo(let id): return "users/\(id)/repos"
        }
    }
}

class ApiService {
    
    static func fetch<T: Decodable>(from url: URL) async throws -> [T] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 && response.statusCode <= 299 else {
            throw ApiError.serverError
        }
        
        guard let result = try? JSONDecoder().decode([T].self, from: data) else {
            throw ApiError.noData
        }
        
        return result
    }
    
    static func fetchUsers() async throws -> [User] {
        let url = ApiPath.users.url
        
        return try await ApiService.fetch(from: url)
    }
    
    static func fetchUserRepos(id: Int) async throws -> [Repo] {
        let url = ApiPath.userRepo(id: String(id)).url
        
        return try await ApiService.fetch(from: url)
    }
}

protocol API {
    static var baseUrl: URL { get }
}

public protocol RawRepresentable {
    
    associatedtype RawValue
    
    init?(rawValue: Self.RawValue)
    
    var rawValue: Self.RawValue { get }
}

extension RawRepresentable where RawValue == String, Self: API {
    var url: URL { Self.baseUrl.appendingPathComponent(rawValue) }
    
    init?(rawValue: String) { nil }
}
