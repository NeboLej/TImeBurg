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
    
    func fetch() -> [TCity]
//    func getCity(id: String) -> TCity
    func updateCurrentCity(house: THouse)
    func updateCurrentCity(city: TCity)
    func updateCurrentCity(history: History)
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
    
    func fetch() -> [TCity] {
        storage.getObjects(CityStored.self).map { TCity(city: $0) }
    }
    
    func updateCurrentCity(house: THouse) {
        var city = getCurrentCity()
        city.buildings.append(house)
        updateCurrentCity(city: city)
    }
    
    func updateCurrentCity(history: History) {
        var city = getCurrentCity()
        city.history.append(history)
        updateCurrentCity(city: city)
    }
    
    func updateCurrentCity(city: TCity) {
        let storageCity = CityStored(value: CityStored.initModel(city: city))
        _ = storage.updateObject(storageCity)
        currentCity.send(city)
        getCityPreviews()
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
        
        let newCity = TCity(id: id, name: formatter.string(from: Date()), image: "", spentTime: 0, comfortRating: 0, greenRating: 0, buildings: [], history: [])
        let storageCity = CityStored(value: CityStored.initModel(city: newCity))
        
        storage.saveObject(storageCity)
        return newCity
    }
}
