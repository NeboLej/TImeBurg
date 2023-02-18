//
//  HouseStored.swift
//  TImeBurg
//
//  Created by Nebo on 16.02.2023.
//

import Foundation
import RealmSwift

protocol HouseProtocol {
    var id: String { get }
    var image: String { get }
    var timeExpenditure: Int { get }
    var width: Double { get }
    var line: Int { get }
    var offsetX: Double { get }
}

class HouseStored: Object, HouseProtocol {
    
    @Persisted var id: String
    @Persisted var image: String
    @Persisted var timeExpenditure: Int
    @Persisted var width: Double
    @Persisted var line: Int
    @Persisted var offsetX: Double
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func initModel(id: String, image: String, timeExpenditure: Int, width: Double, line: Int, offsetX: Double) -> [String: Any] {
        return ["id": id, "image": image, "timeExpenditure": timeExpenditure, "width": width, "line": line, "offsetX": offsetX]
    }
    
    static func initModel(house: THouse) -> [String: Any] {
        return ["id": house.id, "image": house.image, "timeExpenditure": house.timeExpenditure, "width": house.width, "line": house.line, "offsetX": house.offsetX]
    }
}
