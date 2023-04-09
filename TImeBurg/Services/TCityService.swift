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
    let net: CityRepositoryProtocol
    let cityPreviews = CurrentValueSubject<[TCityPreview], Never>([])
    lazy var currentCity: CurrentValueSubject<TCity, Never> = { CurrentValueSubject<TCity, Never> (getCurrentCity()) }()
    
    init(storage: StoreManagerProtocol, net: CityRepositoryProtocol) {
        self.storage = storage
        self.net = net
        getCityPreviews()
    }
    
    private func getCityPreviews() {
        let cities = storage.getObjects(CityStored.self).map { TCityPreview(id: String($0.id), name: $0.name, image: $0.image, spentTime: $0.spentTime) }
        cityPreviews.send(cities.reversed())
    }
    
    func getCity(id: String) -> TCity? {
        let city = storage.getObjects(CityStored.self).first(where: { $0.id == id })
        guard let city = city else { return nil }
        return TCity(city: city)
    }
    
    func fetch() -> [TCity] {
        storage.getObjects(CityStored.self).map { TCity(city: $0) }.reversed()
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
        
        let newCity = TCity(id: id, name: formatter.string(from: Date()), image: "", bgImage: getBackgroundImage(), spentTime: 0, comfortRating: 0, greenRating: 0, buildings: [], history: [])
        let storageCity = CityStored(value: CityStored.initModel(city: newCity))
        
        storage.saveObject(storageCity)
        return newCity
    }
    
    private func getBackgroundImage() -> String {
        let usedBgs = storage.getObjects(CityStored.self).map { $0.bgImage }
        let uniqueUsedBgs = Set(usedBgs)
        let allBgs = Set(net.getBackgroundImages())
        
        let uniqueUnusedBgs = allBgs.subtracting(uniqueUsedBgs)
        
        var image = allBgs.randomElement()
        
        if !uniqueUnusedBgs.isEmpty {
            image = uniqueUnusedBgs.randomElement()
        }
        return image!
    }
}
