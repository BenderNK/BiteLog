//
//  DishView.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 5/25/25.
//

import SwiftUI
import PhotosUI

struct DishView: View {
    @Bindable var dish: Dish
    @FocusState var isTextFieldFocused: Bool
    @State var showBottomSheet: Bool = false
    @State var pickedPhotos: [PhotosPickerItem] = []
    @State var cameraButtonClicked: Bool = false
    @State var selectedImage: UIImage? = nil
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $dish.name)
                    .font(.body)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
                    .focused($isTextFieldFocused)
                
                TextField("Price", value: $dish.price, format: .currency(code: "USD"))
                    .font(.body)
                    .focused($isTextFieldFocused)
            }
            
            Section(header: Text("Rating")) {
                HStack(spacing: 8, content: {
                    ForEach(0..<5, content: { index in
                        if index < dish.rating {
                            Image(systemName: "star.fill")
                                .renderingMode(.template)
                                .foregroundStyle(Color.accentColor)
                                .onTapGesture {
                                    isTextFieldFocused = false
                                    dish.rating = index + 1
                                }
                        } else {
                            Image(systemName: "star")
                                .renderingMode(.template)
                                .foregroundStyle(Color.accentColor)
                                .onTapGesture {
                                    isTextFieldFocused = false
                                    dish.rating = index + 1
                                }
                        }
                        
                    })
                })
            }
            
            Section(header: Text("Remarks")) {
                TextEditor(text: $dish.remarks)
                    .scrollContentBackground(.hidden)
                    .focused($isTextFieldFocused)
                    .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 240)
                    .cornerRadius(4)
                
            }
            
            Section {
                Button("Add Picture", systemImage: "plus", action: {
                    isTextFieldFocused = false
                    showBottomSheet = true
                })
                
                ForEach(0..<dish.images.count, id: \.self) { index in
                    Image(uiImage: UIImage(data: dish.images[index])!)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 200)
                        .clipped()
                }
            }
            
        }
        .scrollContentBackground(.hidden)
        .background {
            // 2. Recreate the default form appearance
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {
                    if isTextFieldFocused {
                        isTextFieldFocused = false
                    }
                }
        }
        .scrollDismissesKeyboard(.interactively) // Allows dismissing via scroll drag
        .navigationTitle(dish.name)
        .navigationBarTitleDisplayMode(.inline)
        .overlay(bottomSheet)
        .fullScreenCover(isPresented: $cameraButtonClicked) {
            CameraImageTaker(selectedImage: $selectedImage)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    // MARK: Camera/Album Bottom Sheet
    @MainActor
    private var bottomSheet: some View {
       return Group {
            if showBottomSheet {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showBottomSheet = false
                    }

                BottomSheet(isPresented: $showBottomSheet) {
                    Text("Camera")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            showBottomSheet = false
                        }

                    Divider()

                    PhotosPicker(selection: $pickedPhotos, matching: .images) {
                            Text("Photo Album")
                                .foregroundStyle(Color.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .padding(.bottom)
                        }
                }
            }
        }
       .frame(maxWidth: .infinity, maxHeight: .infinity)
       .onChange(of: pickedPhotos) { oldValue, newValue in
           if !newValue.isEmpty {
               // user picked photos
               showBottomSheet = false
               Task(priority: .high, operation: {
                   await loadImages(from: newValue)
               })
           }
       }
    }
    
    private func loadImages(from items: [PhotosPickerItem]) async {
        pickedPhotos.removeAll()
        
        do {
            for item in items {
                if let imageData = try await item.loadTransferable(type: Data.self) {
                    dish.images.append(imageData)
                }
            }
        } catch {
            print("Error loading images: \(error.localizedDescription)")
        }
    }
}

#Preview {
    var burgerImage: Data = UIImage(named: "burger")!.pngData()!
    var drinkImage: Data = UIImage(named: "drink")!.pngData()!
    var pancakeImage: Data = UIImage(named: "pancake")!.pngData()!
    
    var previewDish = Dish()
    previewDish.name = "Chorizo"
    previewDish.rating = 2
    previewDish.price = 5.72
    previewDish.images.append(burgerImage)
    previewDish.images.append(drinkImage)
    previewDish.images.append(pancakeImage)
    
    return NavigationStack {
        DishView(
            dish: previewDish
        )
    }
}
