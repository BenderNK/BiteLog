//
//  BiteLogApp.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 5/18/25.
//

import SwiftUI
import SwiftData

@main
struct BiteLogApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Restaurant.self,
            Dish.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RestaurantListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
