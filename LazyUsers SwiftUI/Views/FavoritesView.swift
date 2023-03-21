//
//  FavoritesView.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import SwiftUI

struct FavoritesView: View {
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @FetchRequest(entity: FavoriteUser.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteUser.login, ascending: true)])
    private var favoriteUsers: FetchedResults<FavoriteUser>
    
    var body: some View {
        
        NavigationView {
            VStack {
                if let favoriteUsers,
                   !favoriteUsers.isEmpty {
                    
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(favoriteUsers, id: \.self) { favoriteUser in
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("\(favoriteUser.login ?? "Unknown user")")
                                        .foregroundColor(.primary)
                                        .padding()
                                    Divider()
                                }
                            }
                        }
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(10)
                        .padding()
                    }
                } else {
                    Text("This user has no repos")
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
