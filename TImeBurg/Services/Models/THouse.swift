//
//  THome.swift
//  TImeBurg
//
//  Created by Nebo on 18.01.2023.
//

import Foundation

struct THouse: Equatable {
    let id: String
    let image: String
    var timeExpenditure: Int
    let width: Double
    var line: Int
    var offsetX: Double
    
    init(id: String = UUID().uuidString, image: String, timeExpenditure: Int, width: Double, line: Int, offsetX: Double) {
        self.id = id
        self.image = image
        self.timeExpenditure = timeExpenditure
        self.width = width
        self.line = line
        self.offsetX = offsetX
    }
    
    init(house: HouseProtocol) {
        self.init(id: house.id, image: house.image, timeExpenditure: house.timeExpenditure, width: house.width, line: house.line, offsetX: house.offsetX)
    }
    
    func copy(id: String? = nil, image: String? = nil, timeExpenditure: Int? = nil, width: Double? = nil, line: Int? = nil, offsetX: Double? = nil) -> THouse {
        THouse(id: id ?? self.id, image: image ?? self.image, timeExpenditure: timeExpenditure ?? self.timeExpenditure, width: width ?? self.width, line: line ?? self.line, offsetX: offsetX ?? self.offsetX)
    } 
}
