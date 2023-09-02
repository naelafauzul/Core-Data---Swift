//
//  CoreDataDemoApp.swift
//  CoreDataDemo
//
//  Created by Naela Fauzul Muna on 20/08/23.
//

import SwiftUI

@main
struct CoreDataDemoApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
