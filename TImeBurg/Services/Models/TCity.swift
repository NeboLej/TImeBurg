//
//  TCity.swift
//  TImeBurg
//
//  Created by Nebo on 14.01.2023.
//

import Foundation

struct TCity {
    let id: String
    let name: String
    let image: String
    let spentTime: Int
    let comfortRating: Double
    let greenRating: Double
    let buildings: [THouse]
    let history: [Date: [TBuildingType]]
}
