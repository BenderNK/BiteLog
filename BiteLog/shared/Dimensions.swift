//
//  Dimensions.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 6/15/25.
//

import Foundation

public struct Dimensions {
    /// when you feel you want smallest padding
    public static let microPadding = CGFloat(4)

    /// when you feel you want to cheapskate
    public static let halfPadding = CGFloat(8)

    /// when you feel you want less than standard padding
    public static let midPadding = CGFloat(12)

    /// Padding used in between components and margins of the components
    public static let standardPadding = CGFloat(16)
    
    /// Padding used in between components and margins of the components
    public static let oneAndHalfPadding = CGFloat(24)
    
    /// name says it all - double the padding double the fun.
    public static let doublePadding = CGFloat(32)
    
    /// Standard icon size
    public static let iconSize = CGSize(width: 24, height: 24)
    
    /// icon size used for the buttons in the navigation bar
    public static let navBarIconSize = CGSize(width: 24, height: 24)
    
    /// icon size used for the buttons in the navigation bar
    public static let iconButtonSize = CGSize(width: 36, height: 36)
    
    public static let listSelectionIconSize = CGSize(width: 14, height: 14)
}
