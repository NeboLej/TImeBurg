//
//  TCityService.swift
//  TImeBurg
//
//  Created by Nebo on 24.01.2023.
//

import Foundation
import Combine

protocol TCityServiceProtocol {
    var cityPreviews: CurrentValueSubject<[TCityPreview], Never> { get }
    var currentCity: CurrentValueSubject<TCity, Never> { get }
//
//    func getCity(id: String) -> TCity
    func updateCurrentCity(house: THouse)
}

class TCityService: TCityServiceProtocol {
    
    let storage: StoreManagerProtocol
    let cityPreviews = CurrentValueSubject<[TCityPreview], Never>([])
    lazy var currentCity: CurrentValueSubject<TCity, Never> = { CurrentValueSubject<TCity, Never> (getCurrentCity()) }()
    
    init(storage: StoreManagerProtocol) {
        self.storage = storage
        
        getCityPreviews()
    }
    
    private func getCityPreviews() {
        let cities = storage.getObjects(CityStored.self).map { TCityPreview(id: String($0.id), name: $0.name, image: $0.image, spentTime: $0.spentTime) }
        cityPreviews.send(cities)
    }
    
    func getCity(id: String) -> TCity? {
        let city = storage.getObjects(CityStored.self).first(where: { $0.id == id })
        guard let city = city else { return nil }
        return TCity(city: city)
    }
    
    func updateCurrentCity(house: THouse) {
        var city = getCurrentCity()
        city.buildings.append(house)
        let storageCity = CityStored(value: CityStored.initModel(city: city))
        storage.updateObject(storageCity)
        currentCity.send(city)
    }
    
    private func getCurrentCity() -> TCity {
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        
        let cityId = "\(month)\(year)"
        if let city = getCity(id: cityId) {
            return city
        } else {
            return addNewCity(id: cityId)
        }
    }
    
    private func addNewCity(id: String) -> TCity {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL YYYY"
        
        let newCity = TCity(id: id, name: formatter.string(from: Date()), image: "", spentTime: 0, comfortRating: 0, greenRating: 0, buildings: [], history: [:])
        let storageCity = CityStored(value: CityStored.initModel(city: newCity))
        
        storage.saveObject(storageCity)
        return getCity(id: id)!
    }
}
