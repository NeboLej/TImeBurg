//
//  HouseStored.swift
//  TImeBurg
//
//  Created by Nebo on 15.02.2023.
//

import Foundation
import RealmSwift

protocol HouseProtocol {
    var image: String { get }
    var width: Double { get }
    var startTimeInterval: Int { get }
    var endTimeInterval: Int { get }
}

class HouseStored: Object, HouseProtocol {
    @Persisted var image: String
    @Persisted var width: Double
    @Persisted var startTimeInterval: Int
    @Persisted var endTimeInterval: Int
    
    static func initModel(image: String, width: Double, startTimeInterval: Int, endTimeInterval: Int) -> [String: Any] {
        return ["image": image, "width": width, "startTimeInterval": startTimeInterval, "endTimeInterval": endTimeInterval]
    }
    
    static func initModel(house: HouseProtocol) -> [String: Any] {
        return ["image": house.image, "width": house.width, "startTimeInterval": house.startTimeInterval, "endTimeInterval": house.endTimeInterval]
    }
}
