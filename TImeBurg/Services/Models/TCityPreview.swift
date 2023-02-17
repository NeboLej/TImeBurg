//
//  TCityPreview.swift
//  TImeBurg
//
//  Created by Nebo on 24.01.2023.
//

import Foundation

struct TCityPreview {
    let id: String //month+year 12023
    let name: String
    let image: String
    let spentTime: Int
    
    init(id: String, name: String, image: String, spentTime: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.spentTime = spentTime
    }
    
    init(city: TCity) {
        self.init(id: city.id, name: city.name, image: city.image, spentTime: city.spentTime)
    }
}
