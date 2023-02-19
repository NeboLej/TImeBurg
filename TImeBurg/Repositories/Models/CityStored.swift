//
//  CityStored.swift
//  TImeBurg
//
//  Created by Nebo on 15.02.2023.
//

import Foundation
import RealmSwift

protocol CityProtocol {
    var id: String { get }
    var name: String { get }
    var image: String { get }
    var spentTime: Int { get }
    var comfortRating: Double { get }
    var greenRating: Double { get }
    var buildings: List<HouseStored> { get }
}

class CityStored: Object, CityProtocol {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var spentTime: Int
    @Persisted var comfortRating: Double
    @Persisted var greenRating: Double
//    @Persisted var history
    @Persisted var buildings: List<HouseStored>
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func initModel(id: String, name: String, image: String, spentTime: Int, comfortRating: Double, greenRating: Double, buildings: [HouseStored]) -> [String: Any] {
        return ["id": id, "name": name, "image": image, "spentTime": spentTime, "comfortRating": comfortRating, "greenRating": greenRating, "buildings": buildings]
    }
    
    static func initModel(city: TCity) -> [String: Any] {
        return ["id": city.id, "name": city.name, "image": city.image, "spentTime": city.spentTime, "comfortRating": city.comfortRating, "greenRating": city.greenRating, "buildings": city.buildings.map { HouseStored.initModel(house: $0) }]
    }
    
    convenience init(id: String, name: String, image: String, spentTime: Int, comfortRating: Double, greenRating: Double, buildings: [HouseStored]) {
        self.init()
        self.id = id
        self.name = name
        self.image = image
        self.spentTime = spentTime
        self.comfortRating = comfortRating
        self.greenRating = greenRating
        self.buildings = List<HouseStored>()
        buildings.forEach {
            self.buildings.append($0)
        }
    }
}
