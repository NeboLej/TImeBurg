//
//  TLocalStorageManager.swift
//  TImeBurg
//
//  Created by Nebo on 24.01.2023.
//

import Foundation

protocol TLocalStorageManagerProtocol {
    func getCityPreviews() -> [TCityPreview]
    func getCity(id: String) -> TCity?
    func updateCity(city: TCity) -> Bool
    func addCity(city: TCity)
}

class TLocalStorageManager: TLocalStorageManagerProtocol {
    
    private var cities: [TCity] =  [
        TCity(id: "122022", name: "December 2022", image: "", spentTime: 1220, comfortRating: 0.3, greenRating: 0.8,
              buildings: [.init(image: "House1", timeExpenditure: 200, width: 60, line: 0, offsetX: -50),
                          .init(image: "House2", timeExpenditure: 50, width: 30, line: 0, offsetX: -100),
                          .init(image: "House3", timeExpenditure: 200, width: 60, line: 0, offsetX: 50),
                          .init(image: "House4", timeExpenditure: 150, width: 65, line: 0, offsetX: 100)],
              history: [Date() : [.upgrade(time: 120), .newBuilding(time: 30), .newBuilding(time: 60)]]),
        TCity(id: "12023", name: "January 2023", image: "", spentTime: 1200, comfortRating: 0.7, greenRating: 0.2,
              buildings: [.init(image: "House1", timeExpenditure: 170, width: 60, line: 0, offsetX: -50),
                          .init(image: "House2", timeExpenditure: 50, width: 30, line: 0, offsetX: -100),
                          .init(image: "House3", timeExpenditure: 160, width: 60, line: 0, offsetX: 50),
                          .init(image: "House4", timeExpenditure: 200, width: 65, line: 0, offsetX: 100)],
              history: [Date() : [.upgrade(time: 120), .newBuilding(time: 30), .newBuilding(time: 60)]]),
    ]
    
    func getCityPreviews() -> [TCityPreview] {
        cities.map { TCityPreview(city: $0) }
    }
    
    func getCity(id: String) -> TCity? {
        cities.first { $0.id == id }
    }
    
    func updateCity(city: TCity) -> Bool {
        if cities.contains(where: { $0.id == city.id }) {
            cities.remove(at: cities.firstIndex(where: { $0.id == city.id })!)
            cities.append(city)
            return true
        }
        return false
    }
    
    func addCity(city: TCity) {
        cities.append(city)
    }
}
