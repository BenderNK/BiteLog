//
//  CuisineSelection.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 5/26/25.
//

import Observation
import SwiftUI

@Observable
class CuisineSelection {
    var selectedCuisine: Cuisine {
        get { Cuisine(rawValue: cuisineBinding.wrappedValue) ?? .italian } // Default case
        set { cuisineBinding.wrappedValue = newValue.rawValue }
    }
    
    private let cuisineBinding: Binding<String>
    
    init(_ cuisine: Binding<String>) {
        self.cuisineBinding = cuisine
    }
}
