//
//  FavoritesViewModel.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import Foundation
import CoreData

class FavoritesViewModel: ObservableObject {
    
    private let persistenceController: PersistenceController
    
    @Published private(set) var favoriteUsers: [FavoriteUser] = []
    
    init() {
        persistenceController = PersistenceController.shared
        fetchFavoriteUsers()
    }
    
    func fetchFavoriteUsers() {
        let request = NSFetchRequest<FavoriteUser>(entityName: "FavoriteUser")
        
        do {
            favoriteUsers = try persistenceController.viewContext.fetch(request)
        } catch {
            print("\(error)")
        }
    }
    
    func saveFavoriteUser(user: User) {
        let favoriteUser = user.createFavoriteUser(from: persistenceController.viewContext)
        favoriteUsers.append(favoriteUser)
        persistenceController.save()
    }
    
    func deleteFavoriteUser(at index: IndexSet.Element) {
        let favoriteUser = favoriteUsers.remove(at: index)
        persistenceController.delete(favoriteUser)
    }
}
