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
    var spentTime: Int
    var comfortRating: Double
    var greenRating: Double
    var buildings: [THouse]
    var history: [Date: [TBuildingType]]
    
    init(id: String, name: String, image: String, spentTime: Int, comfortRating: Double, greenRating: Double, buildings: [THouse], history: [Date : [TBuildingType]]) {
        self.id = id
        self.name = name
        self.image = image
        self.spentTime = spentTime
        self.comfortRating = comfortRating
        self.greenRating = greenRating
        self.buildings = buildings
        self.history = history
    }
    
    init(city: CityProtocol) {
        self.init(id: city.id, name: city.name, image: city.image, spentTime: city.spentTime, comfortRating: city.comfortRating, greenRating: city.greenRating, buildings: city.buildings.map { THouse(house: $0) }, history: [:] )
    }
}
