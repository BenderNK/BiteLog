//
//  RestaurantDetailView.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 5/18/25.
//

import SwiftUI
import SwiftData

struct RestaurantDetailView: View {
    @Bindable var restaurant: Restaurant
    
    var body: some View {
        Form {
            Section(header: Text("Restaurant info")) {
                TextField("Name", text: $restaurant.name)
                    .font(.body)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
                
                TextField("Address", text: $restaurant.street1, axis: .vertical)
                    .font(.body)
                
                TextField("Address", text: $restaurant.street2, axis: .vertical)
                    .font(.body)
                
                GeometryReader { metrics in
                    HStack(spacing: 4, content: {
                        TextField("City", text: $restaurant.city)
                            .font(.body)
                            .frame(width: metrics.size.width * 0.50)
                        Divider()
                        TextField("State", text: $restaurant.state)
                            .font(.body)
                            .frame(width: metrics.size.width * 0.20)
                        Divider()
                        TextField("Zipcode", text: $restaurant.zipCode)
                            .font(.body)
                    })
                }
            }
            
            Section(header: Text("Rating"), content: {
                HStack(spacing: 8, content: {
                    ForEach(0..<5, content: { index in
                        if index < restaurant.rating {
                            Image(systemName: "star.fill")
                                .renderingMode(.template)
                                .foregroundStyle(Color.accentColor)
                                .onTapGesture {
                                    restaurant.rating = index + 1
                                }
                        } else {
                            Image(systemName: "star")
                                .renderingMode(.template)
                                .foregroundStyle(Color.accentColor)
                                .onTapGesture {
                                    restaurant.rating = index + 1
                                }
                        }
                        
                    })
                })
            })
            
            
            Section(header: Text("Cuisine"), content: {
                NavigationLink(destination: {
                    
                }, label: {
                    Text(restaurant.cuisine)
                })
            })
        }
        .navigationTitle(restaurant.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let previewRestaurant = Restaurant()
    previewRestaurant.name = "Azul Verde"
    previewRestaurant.city = "Minneapolis"
    previewRestaurant.street1 = "1827 32nd St"
    previewRestaurant.street2 = "Suite 240"
    previewRestaurant.state = "MN"
    previewRestaurant.zipCode = "55406"
    previewRestaurant.rating = 3
    previewRestaurant.cuisine = "Columbian"
    
    return RestaurantDetailView(restaurant: previewRestaurant)
        .modelContainer(for: Restaurant.self, inMemory: true)
}
