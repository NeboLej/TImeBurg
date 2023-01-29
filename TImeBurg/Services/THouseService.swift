//
//  THouseService.swift
//  TImeBurg
//
//  Created by Nebo on 28.01.2023.
//

import Foundation

protocol THouseServiceProtocol {
    func getNewHouse(time: Int) -> THouse
    func upgradeHouse(oldHouse: THouse, time: Int) -> THouse
}

class THouseService: THouseServiceProtocol {
    
    private let storage: TLocalStorageManagerProtocol
    
    init(storage: TLocalStorageManagerProtocol) {
        self.storage = storage
    }
    
    func getNewHouse(time: Int) -> THouse {
        let house = storage.getHouses(time: time).randomElement()
        guard let house = house else { return THouse(image: "House2", timeExpenditure: time, width: 30, line: 0, offsetX: 0) }
        let newHouse = THouse(image: house.image, timeExpenditure: time, width: house.width, line: 0, offsetX: 0)
        return newHouse
    }
    
    func upgradeHouse(oldHouse: THouse, time: Int) -> THouse {
        let generalTime = time + oldHouse.timeExpenditure
        let newHouse = storage.getHouses(time: generalTime).randomElement()
        guard let newHouse = newHouse else { return oldHouse.copy(timeExpenditure: generalTime) }
        return oldHouse.copy(image: newHouse.image, timeExpenditure: generalTime, width: newHouse.width)
    }
}
