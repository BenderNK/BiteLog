//
//  RestaurantListView.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 5/18/25.
//

import SwiftUI
import SwiftData

struct RestaurantListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var restaurants: [Restaurant]

    var body: some View {
        NavigationStack {
            List {
                ForEach(restaurants) { eachRestaurant in
                    NavigationLink {
                        Text("Hello World")
                    } label: {
                        Text(eachRestaurant.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Restaurant(name: "New")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(restaurants[index])
            }
        }
    }
}

#Preview {
    RestaurantListView()
        .modelContainer(for: Restaurant.self, inMemory: true)
}
