//
//  CuisineView.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 5/25/25.
//

import SwiftUI

struct CuisineView: View {
    @Bindable var cuisineSelection: CuisineSelection
    @State var searchQuery: String = ""
    
    var body: some View {
        List {
            Section(content: {
                ForEach(Cuisine.allCases) { eachCuisine in
                    if searchQuery.isEmpty {
                        listItem(with: eachCuisine)
                    } else {
                        if eachCuisine.rawValue.contains(searchQuery) {
                            listItem(with: eachCuisine)
                        }
                    }
                }
            }, header: {
                SearchBar(placeholder: "Search", searchText: $searchQuery)
            })
        }
        .listStyle(.plain)
        .navigationTitle("Cuisines")
        .navigationBarTitleDisplayMode(.inline)
        .modifier(KeyboardToolbar())
    }
    
    @MainActor
    private func listItem(with cuisine: Cuisine) -> some View {
        HStack {
            Text(cuisine.rawValue)
                .frame(maxWidth: .infinity, alignment: .leading)
            if cuisine == cuisineSelection.selectedCuisine {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            cuisineSelection.selectedCuisine = cuisine
        }
    }
}

#Preview {
    @Previewable @State var cuisineBinding: String = "Japanese"
    @Previewable @State var searchText = "rea"
    
    var selectedCuisine = CuisineSelection($cuisineBinding)
    let cuisineView = CuisineView(
        cuisineSelection: selectedCuisine
    )
    
    cuisineView.searchQuery = searchText
    
    return NavigationStack {
        cuisineView
    }
}
