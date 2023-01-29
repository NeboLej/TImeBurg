//
//  TCity.swift
//  TImeBurg
//
//  Created by Nebo on 14.01.2023.
//

import Foundation

struct TCity {
    var id: String
    var name: String
    var image: String
    var spentTime: Int
    var comfortRating: Double
    var greenRating: Double
    var buildings: [THouse]
    var history: [Date: [TBuildingType]]
}
