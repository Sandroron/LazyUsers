//
//  HomeViewModel.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published private(set) var users: [User]?
    @Published private(set) var isLoading = false
    
    @Published private(set) var error: ApiError? = nil
    @Published var isError = false
    
    @MainActor
    func fetchUsers() async {
        defer { isLoading = false }
        isLoading = true
        
        do {
            users = try await ApiService.fetchUsers()
        } catch {
            if let fetchError = error as? ApiError {
                self.error = fetchError
                isError = true
            }
        }
    }
}
