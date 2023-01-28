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
    
    func getCity(id: String) -> TCity
}

class TCityService: TCityServiceProtocol {
    
    let storage: TLocalStorageManagerProtocol
    let cityPreviews = CurrentValueSubject<[TCityPreview], Never>([])
    lazy var currentCity: CurrentValueSubject<TCity, Never> = { CurrentValueSubject<TCity, Never> (getCurrentCity()) }()
    
    init(storage: TLocalStorageManagerProtocol) {
        self.storage = storage
        
        getCityPreviews()
    }
    
    func getCity(id: String) -> TCity {
        storage.getCity(id: id)!
    }
    
    private func getCityPreviews() {
        cityPreviews.send(storage.getCityPreviews())
    }
    
    private func getCurrentCity() -> TCity {
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        
        let cityId = "\(month)\(year)"
        if let city = storage.getCity(id: cityId) {
            return city
        } else {
            return addNewCity(id: cityId)
        }
    }
    
    private func addNewCity(id: String) -> TCity {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL YYYY"
        
        let newCity = TCity(id: id, name: formatter.string(from: Date()), image: "", spentTime: 0, comfortRating: 0, greenRating: 0, buildings: [], history: [:])
        storage.addCity(city: newCity)
        return storage.getCity(id: id)!
    }
}
