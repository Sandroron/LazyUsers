//
//  HomeView.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                if homeViewModel.isLoading {
                    
                    ProgressView()
                } else {
                    
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(homeViewModel.users ?? []) { user in
                                NavigationLink(
                                    destination: UserRepoListView(userRepoListViewModel: UserRepoListViewModel(user: user)),
                                    label: {
                                        VStack(alignment: .leading, spacing: 0) {
                                            
                                            HStack {
                                                
                                                Text("\(user.login)")
                                                    .foregroundColor(.primary)
                                                    .padding()
                                                Spacer()
                                                
                                                if let index = favoritesViewModel.favoriteUsers.firstIndex(where: {$0.login == user.login}) {
                                                    
                                                    Button(action: {
                                                        favoritesViewModel.deleteFavoriteUser(at: index)
                                                    }) {
                                                        Image(systemName: "heart.fill")
                                                            .font(.title)
                                                            .foregroundColor(Color(uiColor: .systemBlue))
                                                    }
                                                    .padding()
                                                } else {
                                                    
                                                    Button(action: {
                                                        favoritesViewModel.saveFavoriteUser(user: user)
                                                    }) {
                                                        Image(systemName: "heart")
                                                            .font(.title)
                                                            .foregroundColor(Color(uiColor: .systemBlue))
                                                    }
                                                    .padding()
                                                }
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
                }
            }
            .navigationTitle("Users")
            .background(Color(uiColor: .secondarySystemBackground))
            .onAppear(perform: {
                Task {
                    await homeViewModel.fetchUsers()
                }
            })
            .alert(isPresented: $homeViewModel.isError,
                   error: homeViewModel.error) {
                
                Button {
                    Task {
                        await homeViewModel.fetchUsers()
                    }
                } label: {
                    Text("Retry")
                }
            }
        }
    }
}

struct ListSelectionStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color(uiColor: .secondarySystemFill) : Color(uiColor: .systemBackground))
    }
}
