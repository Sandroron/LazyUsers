//
//  User.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import Foundation
import CoreData

struct User: Identifiable, Decodable {
    
    var id: Int
    var login: String
    
    func getFavoriteUser(from context: NSManagedObjectContext) -> FavoriteUser {
        
        let favoriteUser = FavoriteUser(context: context)
        favoriteUser.login = login
        favoriteUser.id = Int64(id)
        
        return favoriteUser
    }
}
