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
    var bgImage: String { get }
    var spentTime: Int { get }
    var comfortRating: Double { get }
    var greenRating: Double { get }
    var buildings: List<HouseStored> { get }
    var history: List<HistoryStored> { get }
}

class CityStored: Object, CityProtocol {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var bgImage: String
    @Persisted var spentTime: Int
    @Persisted var comfortRating: Double
    @Persisted var greenRating: Double
    @Persisted var buildings: List<HouseStored>
    @Persisted var history: List<HistoryStored>
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func initModel(id: String, name: String, image: String, bgImage: String, spentTime: Int, comfortRating: Double, greenRating: Double, buildings: [HouseStored], history: [HistoryStored]) -> [String: Any] {
        return ["id": id, "name": name, "image": image, "bgImage": bgImage, "spentTime": spentTime, "comfortRating": comfortRating, "greenRating": greenRating, "buildings": buildings, "history": history]
    }
    
    static func initModel(city: TCity) -> [String: Any] {
        return ["id": city.id, "name": city.name, "image": city.image, "bgImage": city.bgImage, "spentTime": city.spentTime, "comfortRating": city.comfortRating, "greenRating": city.greenRating, "buildings": city.buildings.map { HouseStored.initModel(house: $0) }, "history": city.history.map {HistoryStored.initModel(history: $0)}]
    }
    
    convenience init(id: String, name: String, image: String, bgImage: String, spentTime: Int, comfortRating: Double, greenRating: Double, buildings: [HouseStored], history: [HistoryStored]) {
        self.init()
        self.id = id
        self.name = name
        self.image = image
        self.bgImage = bgImage
        self.spentTime = spentTime
        self.comfortRating = comfortRating
        self.greenRating = greenRating
        self.buildings = List<HouseStored>()
        buildings.forEach {
            self.buildings.append($0)
        }
        self.history = List<HistoryStored>()
        history.forEach {
            self.history.append($0)
        }
    }
}
