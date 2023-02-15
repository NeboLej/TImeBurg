//
//  THome.swift
//  TImeBurg
//
//  Created by Nebo on 18.01.2023.
//

import Foundation

struct THouse {
    let id = UUID().uuidString
    let image: String
    let timeExpenditure: Int
    let width: Double
    let line: Int
    let offsetX: Double
    
    init(image: String, timeExpenditure: Int, width: Double, line: Int, offsetX: Double) {
        self.image = image
        self.timeExpenditure = timeExpenditure
        self.width = width
        self.line = line
        self.offsetX = offsetX
    }
    
    init(house: UserHouseStored) {
        self.init(image: house.image, timeExpenditure: house.timeExpenditure, width: house.width, line: house.line, offsetX: house.offsetX)
    }
    
    func copy(image: String? = nil, timeExpenditure: Int? = nil, width: Double? = nil, line: Int? = nil, offsetX: Double? = nil) -> THouse {
        THouse(image: image ?? self.image, timeExpenditure: timeExpenditure ?? self.timeExpenditure, width: width ?? self.width, line: line ?? self.line, offsetX: offsetX ?? self.offsetX)
    } 
}
