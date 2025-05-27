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
    
    /// this state variable allows to dismiss the keyboard without having to resort
    /// to UIKit functions.
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("Restaurant info")) {
                    TextField("Name", text: $restaurant.name)
                        .font(.body)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.words)
                        .focused($isTextFieldFocused)
                    
                    TextField("Address", text: $restaurant.street1, axis: .vertical)
                        .font(.body)
                        .focused($isTextFieldFocused)
                    
                    TextField("Address", text: $restaurant.street2, axis: .vertical)
                        .font(.body)
                        .focused($isTextFieldFocused)
                    
                    GeometryReader { metrics in
                        HStack(spacing: 4, content: {
                            TextField("City", text: $restaurant.city)
                                .font(.body)
                                .focused($isTextFieldFocused)
                                .frame(width: metrics.size.width * 0.50)
                                
                            Divider()
                            
                            TextField("State", text: $restaurant.state)
                                .font(.body)
                                .focused($isTextFieldFocused)
                                .frame(width: metrics.size.width * 0.20)
                            
                            Divider()
                            
                            TextField("Zipcode", text: $restaurant.zipCode)
                                .font(.body)
                                .focused($isTextFieldFocused)
                        })
                    }
                }
                
                Section(header: Text("Overall Rating"), content: {
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
                        CuisineView(cuisineSelection: CuisineSelection($restaurant.cuisine))
                    }, label: {
                        Text(restaurant.cuisine)
                    })
                })
                
                Section(header: Text("Dishes"), content: {
                    Button("Add", systemImage: "plus", action: addNewDish)
                    
                    ForEach(restaurant.dishes, content: { eachDish in
                        NavigationLink(destination: {
                            DishView(dish: eachDish)
                        }, label: {
                            HStack(spacing: 0) {
                                Text(eachDish.name)
                                Spacer()
                                    .frame(width: 8)
                                
                                ForEach(0..<eachDish.rating, id: \.self) { _ in
                                    Text("⭐️")
                                }
                                
                            }
                        })
                    })
                })
            }
            
            // Transparent overlay for keyboard dismissal
            if isTextFieldFocused {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isTextFieldFocused = false
                    }
                    .ignoresSafeArea()
            }
        }
        
        .navigationTitle(restaurant.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func addNewDish() {
        withAnimation {
            let newDish = Dish(name: "New")
            restaurant.dishes.append(newDish)
        }
    }
}

#Preview {
    var burrito = Dish()
    burrito.name = "Burrito"
    burrito.rating = 3
    
    var empanada = Dish()
    empanada.name = "Empanada Pollo"
    empanada.rating = 5
    
    let previewRestaurant = Restaurant()
    previewRestaurant.name = "Azul Verde"
    previewRestaurant.city = "Minneapolis"
    previewRestaurant.street1 = "1827 32nd St"
    previewRestaurant.street2 = "Suite 240"
    previewRestaurant.state = "MN"
    previewRestaurant.zipCode = "55406"
    previewRestaurant.rating = 3
    previewRestaurant.cuisine = "Columbian"
    previewRestaurant.dishes.append(burrito)
    previewRestaurant.dishes.append(empanada)

    
    return RestaurantDetailView(restaurant: previewRestaurant)
        .modelContainer(for: Restaurant.self, inMemory: true)
}
