//
//  TCity.swift
//  TImeBurg
//
//  Created by Nebo on 14.01.2023.
//

import Foundation

struct TCity: Equatable {
    var id: String
    var name: String
    var image: String
    var bgImage: String
    var spentTime: Int
    var comfortRating: Double
    var greenRating: Double
    var buildings: [THouse]
    var history: [History]
    
    init(id: String, name: String, image: String, bgImage: String, spentTime: Int, comfortRating: Double, greenRating: Double, buildings: [THouse], history: [History]) {
        self.id = id
        self.name = name
        self.image = image
        self.bgImage = bgImage
        self.spentTime = spentTime
        self.comfortRating = comfortRating
        self.greenRating = greenRating
        self.buildings = buildings
        self.history = history
    }
    
    init(city: CityProtocol) {
        self.init(id: city.id, name: city.name, image: city.image, bgImage: city.bgImage, spentTime: city.spentTime, comfortRating: city.comfortRating, greenRating: city.greenRating, buildings: city.buildings.map { THouse(house: $0) }, history: city.history.map { History(history: $0) })
    }
}
