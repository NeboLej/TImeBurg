//
//  TagVM.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import SwiftUI

class TagVM: ObservableObject {
    
    var id: String
    @Published var name: String
    @Published var color: Color
    
    init(id: String = UUID().uuidString, name: String, color: Color) {
        self.id = id
        self.name = name
        self.color = color
    }
    
    convenience init(tag: Tag) {
        self.init(id: tag.id, name: tag.name, color: Color(hex: tag.color))
    }
}

extension TagVM: Identifiable, Hashable {
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public static func == (lhs: TagVM, rhs: TagVM) -> Bool {
        return lhs.id == rhs.id
    }
}
