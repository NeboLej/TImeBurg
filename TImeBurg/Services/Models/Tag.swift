//
//  Tag.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import Foundation

struct Tag: Hashable {
    let id: String
    let name: String
    let color: String
    
    init(id: String = UUID().uuidString, name: String, color: String) {
        self.id = id
        self.name = name
        self.color = color
    }
}
