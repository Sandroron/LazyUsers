//
//  UserRepoListView.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import SwiftUI

struct UserRepoListView: View {
    
    @StateObject var userRepoListViewModel: UserRepoListViewModel
    
    var body: some View {
        
        VStack {
            if userRepoListViewModel.isLoading {
                
                ProgressView()
            } else {
                
                if let repos = userRepoListViewModel.repos,
                   !repos.isEmpty {
                    
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(repos) { repo in
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("\(repo.name)")
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
        }
        .navigationTitle("\(userRepoListViewModel.user.login)'s repos")
        .onAppear(perform: {
            Task {
                await userRepoListViewModel.fetchRepos()
            }
        })
        .alert(isPresented: $userRepoListViewModel.isError,
               error: userRepoListViewModel.error) {
            
            Button {
                Task {
                    await userRepoListViewModel.fetchRepos()
                }
            } label: {
                Text("Retry")
            }
        }
    }
}
