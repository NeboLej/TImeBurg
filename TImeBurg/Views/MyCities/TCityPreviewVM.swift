//
//  TCityPreviewVM.swift
//  TImeBurg
//
//  Created by Nebo on 02.02.2023.
//

import UIKit

class TCityPreviewVM: ObservableObject, Identifiable {
    @Published var id: String
    @Published var name: String
    @Published var image: UIImage?
    @Published var spentTime: Int
    
    init(id: String, name: String, image: String, spentTime: Int, parent: Any? = nil) {
        let imageService = ImageService()
        self.id = id
        self.name = name
        self.image = imageService.getImage(fileName: id)
        self.spentTime = spentTime
    }
    
    convenience init(city: TCityPreview, parent: Any? = nil) {
        self.init(id: city.id, name: city.name, image: city.image, spentTime: city.spentTime, parent: parent)
    }
}
