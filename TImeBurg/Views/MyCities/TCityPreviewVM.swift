//
//  TCityPreviewVM.swift
//  TImeBurg
//
//  Created by Nebo on 02.02.2023.
//

import Foundation

class TCityPreviewVM: ObservableObject, Identifiable {
    @Published var id: String
    @Published var name: String
    @Published var iamge: String
    @Published var spentTime: Int
    
    init(id: String, name: String, iamge: String, spentTime: Int, parent: Any? = nil) {
        self.id = id
        self.name = name
        self.iamge = iamge
        self.spentTime = spentTime
    }
    
    convenience init(city: TCityPreview, parent: Any? = nil) {
        self.init(id: city.id, name: city.name, iamge: city.image, spentTime: city.spentTime, parent: parent)
    }
}
