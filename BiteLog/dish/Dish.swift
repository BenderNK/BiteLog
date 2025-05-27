//
//  Dish.swift
//  BiteLog
//
//  Created by Nessa Kucuk, Turker on 5/19/25.
//

import Foundation
import UIKit
import SwiftData

@Model
final class Dish {
    var id: String
    var name: String
    var remarks: String
    var price: Decimal?
    var rating: Int
    
    @Attribute(.externalStorage)
    var images: [Data]
    var modifiedDate: Date
    
    init(name: String = "") {
        self.id = UUID().uuidString
        self.name = name
        self.remarks = ""
        self.price = nil
        self.rating = 0
        self.images = []
        self.modifiedDate = Date()
    }
}

extension Dish {
    var pictures: [UIImage] {
        images.compactMap {
            UIImage(data: $0)
        }
    }
}
