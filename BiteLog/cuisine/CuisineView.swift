//
//  CuisineView.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 5/25/25.
//

import SwiftUI

struct CuisineView: View {
    @Bindable var cuisineSelection: CuisineSelection
    
    var body: some View {
        List {
            ForEach(Cuisine.allCases) { eachCuisine in
                HStack {
                    Text(eachCuisine.rawValue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if eachCuisine == cuisineSelection.selectedCuisine {
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    cuisineSelection.selectedCuisine = eachCuisine
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var cuisineBinding: String = "Japanese"
    var selectedCuisine = CuisineSelection($cuisineBinding)
    return CuisineView(cuisineSelection: selectedCuisine)
}
