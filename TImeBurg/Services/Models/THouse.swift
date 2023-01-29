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
    
    func copy(image: String? = nil, timeExpenditure: Int? = nil, width: Double? = nil, line: Int? = nil, offsetX: Double? = nil) -> THouse {
        THouse(image: image ?? self.image, timeExpenditure: timeExpenditure ?? self.timeExpenditure, width: width ?? self.width, line: line ?? self.line, offsetX: offsetX ?? self.offsetX)
    }
}
