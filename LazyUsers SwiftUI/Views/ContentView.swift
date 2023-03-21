//
//  ContentView.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .environment(\.managedObjectContext, managedObjectContext)
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .environment(\.managedObjectContext, managedObjectContext)
        }
    }
}
