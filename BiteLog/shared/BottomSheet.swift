//
//  BottomSheet.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 5/26/25.
//

import SwiftUI

public struct BottomSheet<Content: View>: View {
    @Binding public var isPresented: Bool
    public let content: Content
    
    public init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    public var body: some View {
        VStack {
            Spacer()
            VStack {
                content
            }
            .background(Color.white)
            .shadow(radius: 20)
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.all)
        .animation(.easeInOut(duration: 0.35))
        .transition(.move(edge: .bottom))
        .onTapGesture {
            withAnimation {
                self.isPresented = false
            }
        }
    }
}
