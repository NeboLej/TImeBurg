//
//  UserHouseStored.swift
//  TImeBurg
//
//  Created by Nebo on 16.02.2023.
//

import Foundation
import RealmSwift

class UserHouseStored: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var image: String
    @Persisted var timeExpenditure: Int
    @Persisted var width: Double
    @Persisted var line: Int
    @Persisted var offsetX: Double
    
    static func initModel(image: String, timeExpenditure: Int, width: Double, line: Int, offsetX: Double) -> [String: Any] {
        return ["image": image, "timeExpenditure": timeExpenditure, "width": width, "line": line, "offsetX": offsetX]
    }
    
    static func initModel(house: THouse) -> [String: Any] {
        return ["image": house.image, "timeExpenditure": house.timeExpenditure, "width": house.width, "line": house.line, "offsetX": house.offsetX]
    }
}
