//
//  KeyboardToolbar.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 6/15/25.
//


import SwiftUI

struct KeyboardToolbar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )
                    }
                }
            }
    }
}