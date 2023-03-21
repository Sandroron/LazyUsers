//
//  ContentView.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let favoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        TabView {
            HomeView(favoritesViewModel: favoritesViewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            FavoritesView(favoritesViewModel: favoritesViewModel)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}
