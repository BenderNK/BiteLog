//
//  Restaurant.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 5/18/25.
//

import Foundation
import SwiftData

@Model
final class Restaurant {
    var id: String
    var name: String
    var street1: String
    var street2: String
    var city: String
    var state: String
    var zipCode: String
    var rating: Int
    var cuisine: String
    var dishes: [Dish]
    
    init(name: String = "") {
        self.id = UUID().uuidString
        self.name = name
        self.city = ""
        self.rating = 0
        self.cuisine = ""
        self.street1 = ""
        self.street2 = ""
        self.state = ""
        self.zipCode = ""
        self.dishes = []
    }
}
