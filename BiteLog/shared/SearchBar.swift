//
//  SearchBar.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 6/15/25.
//

import SwiftUI

public struct SearchBar: View {
    
    let placeholder: String?
    @Binding var searchText: String
    
    public init(placeholder: String? = nil, searchText: Binding<String>) {
        self.placeholder = placeholder
        self._searchText = searchText
    }

    public var body: some View {
        
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .foregroundStyle(Color.systemGray)
                .frame(
                    width: 18,
                    height: 18
                )
            
            ZStack(alignment: .trailing) {
                TextField("", text: $searchText,
                          prompt: Text(LocalizedStringKey(placeholder ?? ""))
                    .foregroundStyle(Color.systemGray3)
                )
                .padding()
                .padding(.trailing, Dimensions.oneAndHalfPadding)
                .frame(height: 40)
                .background(Color.secondarySystemBackground)
                .foregroundStyle(Color.systemGray2)
                .textFieldStyle(.plain)
                .font(.system(size: 15))
                .autocorrectionDisabled()
                .cornerRadius(5)
                
                if searchText.count > 0 {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.systemGray3)
                        .frame(
                            width: 20,
                            height: 20
                        )
                        .padding(.trailing, Dimensions.halfPadding)
                        .onTapGesture {
                            searchText = ""
                        }
                }
            }
            
        }
    }
}

#Preview {
    @Previewable @State var searchText: String = ""
    @Previewable @State var searchText2: String = "Food"
    return VStack {
        // i like german cars
        SearchBar(placeholder: "Search anything - if you believe it", searchText: $searchText)
        Spacer()
            .frame(height: 20)
        
        SearchBar(searchText: $searchText2)
        Spacer()
    }
    .padding()
}
