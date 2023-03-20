//
//  HomeView.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        
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
                                        Text("\(user.login)")
                                            .foregroundColor(.primary)
                                            .padding()
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
//        .task() {
//            await homeViewModel.fetchUsers()
//        }
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

struct ListSelectionStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color(uiColor: .secondarySystemFill) : Color(uiColor: .systemBackground))
    }
}
