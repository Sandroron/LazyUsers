//
//  UserRepoListViewModel.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import Foundation

class UserRepoListViewModel: ObservableObject {
    
    @Published private(set) var repos: [Repo]?
    @Published private(set) var isLoading = false
    
    @Published private(set) var error: ApiError? = nil
    @Published var isError = false
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    convenience init(favoriteUser: FavoriteUser) {
        let user = User(id: Int(favoriteUser.id), login: favoriteUser.login ?? "Unknown user")
        self.init(user: user)
    }
    
    @MainActor
    func fetchRepos() async {
        defer { isLoading = false }
        isLoading = true
        
        do {
            repos = try await ApiService.fetchUserRepos(id: user.id)
        } catch {
            if let fetchError = error as? ApiError {
                self.error = fetchError
                isError = true
            }
        }
    }
}
