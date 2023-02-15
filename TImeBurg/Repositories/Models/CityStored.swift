//
//  CityStored.swift
//  TImeBurg
//
//  Created by Nebo on 15.02.2023.
//

import Foundation
import RealmSwift

class CityStored: Object {
    
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var spentTime: Int
    @Persisted var comfortRating: Double
    @Persisted var greenRating: Double
//    @Persisted var history
    @Persisted var buildings: List<UserHouseStored>
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func initModel(id: String, name: String, image: String, spentTime: Int, comfortRating: Double, greenRating: Double, buildings: [UserHouseStored]) -> [String: Any] {
        return ["id": id, "name": name, "image": image, "spentTime": spentTime, "comfortRating": comfortRating, "greenRating": greenRating, "buildings": buildings]
    }
    
    static func initModel(city: TCity) -> [String: Any] {
        return ["id": city.id, "name": city.name, "image": city.image, "spentTime": city.spentTime, "comfortRating": city.comfortRating, "greenRating": city.greenRating, "buildings": city.buildings.map { UserHouseStored.initModel(house: $0) }]
    }
}
