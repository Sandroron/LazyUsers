//
//  LazyUsers_SwiftUIApp.swift
//  LazyUsers SwiftUI
//
//  Created by CT Razumnyi on 20.03.2023.
//

import SwiftUI

@main
struct LazyUsers_SwiftUIApp: App {
    let persistanceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistanceController.container.viewContext)
        }
        .onChange(of: scenePhase, perform: { newScenePhase in
            
            if case .background = newScenePhase {
                persistanceController.save()
            }
        })
    }
}
