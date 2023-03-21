//
//  FavoritesView.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                if let favoriteUsers = favoritesViewModel.favoriteUsers,
                   !favoriteUsers.isEmpty {
                    
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(Array(favoriteUsers.enumerated()), id: \.element) { index, favoriteUser in
                                NavigationLink(
                                    destination: UserRepoListView(userRepoListViewModel: UserRepoListViewModel(favoriteUser: favoriteUser)),
                                    label: {
                                        VStack(alignment: .leading, spacing: 0) {
                                            HStack {
                                                Text("\(favoriteUser.login ?? "Unknown User")")
                                                    .foregroundColor(.primary)
                                                    .padding()
                                                Spacer()
                                                
                                                Button(action: {
                                                    favoritesViewModel.deleteFavoriteUser(at: index)
                                                }) {
                                                    Image(systemName: "heart.fill")
                                                        .font(.title)
                                                        .foregroundColor(Color(uiColor: .systemBlue))
                                                }
                                                .padding()
                                            }
                                            Divider()
                                        }
                                    })
                                .buttonStyle(ListSelectionStyle())
                            }
                        }
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(10)
                        .padding()
                    }
                } else {
                    Text("No Favorites")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("Favorites")
            .background(Color(uiColor: .secondarySystemBackground))
        }
    }
}
