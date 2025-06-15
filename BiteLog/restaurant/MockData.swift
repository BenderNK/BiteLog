//
//  MockData.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 6/15/25.
//

import Foundation

class MockData {
    
    // Helper function to generate random dates within the last 3 years
    func randomDate() -> Date {
        let randomTime = TimeInterval.random(in: 0..<(3 * 365 * 24 * 3600))
        return Date().addingTimeInterval(-randomTime)
    }
    
    // Generate mock restaurants
    func generateMockRestaurants() -> [Restaurant] {
        // Data pools for randomization
        let restaurantNames = [
            "Azure Vine Bistro", "Golden Harvest", "Saffron Skies", "Marigold Kitchen", "Copper Pot",
            "Velvet Truffle", "Harbor Light", "Mystic Grill", "Noble Fork", "Twilight Terrace",
            "Emerald Eats", "Royal Basil", "Silk Road Inn", "Coastal Crust", "Whispering Willow",
            "Sunset Pier", "Midnight Olive", "Crimson Clove", "Luna Sea", "Ginger Root"
        ]
        
        let streetNames = ["Main", "Oak", "Maple", "Elm", "Pine", "Cedar", "Birch", "Spruce", "First", "Second"]
        let streetTypes = ["St", "Ave", "Blvd", "Rd", "Ln"]
        let cities = ["Seattle", "Portland", "San Francisco", "Austin", "Denver", "Chicago", "Brooklyn", "Boston", "Nashville", "Miami"]
        let states = ["CA", "WA", "OR", "TX", "CO", "IL", "NY", "MA", "TN", "FL"]
        let cuisines = ["Italian", "Mexican", "Japanese", "American", "Thai", "Indian", "French", "Mediterranean", "Vegetarian", "Fusion"]
        
        let dishNames = [
            "Truffle Pasta", "Seafood Paella", "Beef Wellington", "Mushroom Risotto", "Chicken Satay",
            "Fish Tacos", "Vegetable Curry", "Ramen Bowl", "Caesar Salad", "Burgers",
            "Sushi Platter", "Margherita Pizza", "Pho Bowl", "BBQ Ribs", "Falafel Wrap",
            "Duck Confit", "Lobster Roll", "Steak Frites", "Veggie Burger", "Charcuterie Board"
        ]
        
        let dishRemarks = [
            "Signature dish", "Chef's recommendation", "Seasonal special", "Gluten-free option available",
            "Spicy", "Vegetarian delight", "Fresh local ingredients", "House favorite", "Award-winning recipe"
        ]
        
        var restaurants: [Restaurant] = []
        
        for i in 0..<20 {
            let restaurant = Restaurant(name: restaurantNames[i])
            restaurant.street1 = "\(Int.random(in: 100...999)) \(streetNames.randomElement()!) \(streetTypes.randomElement()!)"
            restaurant.street2 = Bool.random() ? "Apt \(Int.random(in: 1...50))" : ""
            restaurant.city = cities.randomElement()!
            restaurant.state = states.randomElement()!
            restaurant.zipCode = "\(Int.random(in: 10000...99999))"
            restaurant.rating = Int.random(in: 1...5)
            restaurant.cuisine = cuisines.randomElement()!
            restaurant.modifiedDate = randomDate()
            
            // Add 2-3 dishes
            let dishCount = Int.random(in: 2...3)
            for _ in 0..<dishCount {
                let dish = Dish(name: dishNames.randomElement()!)
                dish.remarks = dishRemarks.randomElement()!
                dish.price = Decimal(Double.random(in: 8.99...34.99)).rounded(toPlaces: 2)
                dish.rating = Int.random(in: 1...5)
                dish.modifiedDate = randomDate()
                restaurant.dishes.append(dish)
            }
            
            restaurants.append(restaurant)
        }
        
        return restaurants
    }
}

// Extension for decimal rounding
extension Decimal {
    func rounded(toPlaces places: Int) -> Decimal {
        var result = Decimal()
        var localCopy = self
        NSDecimalRound(&result, &localCopy, places, .plain)
        return result
    }
}
