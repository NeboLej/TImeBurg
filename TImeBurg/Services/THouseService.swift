//
//  THouseService.swift
//  TImeBurg
//
//  Created by Nebo on 28.01.2023.
//

import Foundation
import Combine

protocol THouseServiceProtocol {
    func getNewHouse(time: Int) -> THouse
//    func upgradeHouse(oldHouse: THouse, time: Int) -> THouse
}

class THouseService: THouseServiceProtocol {
    
    private let storage: StoreManagerProtocol
    private let cityService: TCityServiceProtocol
    private var cancellableSet: Set<AnyCancellable> = []

    
    init(storage: StoreManagerProtocol, cityService: TCityServiceProtocol) {
        self.storage = storage
        self.cityService = cityService
    }
    
    func getNewHouse(time: Int) -> THouse {
        let building = storage.getObjects(BuildingStored.self).filter { ($0.startTimeInterval...$0.endTimeInterval).contains(time) }.randomElement()
        guard let building = building else { return THouse(image: "House4", timeExpenditure: time, width: 50, line: 0, offsetX: searchFreeSpace(width: 30.0)) }
        let newHouse = THouse(image: building.image, timeExpenditure: time, width: building.width, line: 0, offsetX: searchFreeSpace(width: building.width))
        return newHouse
    }
    
    private func searchFreeSpace(width: Double) -> Double {
        let screenWidth = Utilts.screenWidth
        let padding = 5.0
        
        let halfWith = Int(screenWidth/2) - 15
        for x in stride(from: 0, to: halfWith, by: 5) {
            
            if intervalСomparison(interval: (Double(x) - width/2 - padding)...(Double(x) + width/2 + padding)) {
                return Double(x)
            }
            
            if intervalСomparison(interval: (Double(-x) - width/2 - padding)...(Double(-x) + width/2 + padding)) {
                return Double(-x)
            }
        }
        return 0.0
    }
    
    private func intervalСomparison(interval: ClosedRange<Double>) -> Bool {
        let houses = cityService.currentCity.value.buildings
        
        for house in houses {
            if interval.overlaps( (house.offsetX - house.width/2)...(house.offsetX + house.width/2) ) {
                return false
            }
        }
        return true
    }
    
//    func upgradeHouse(oldHouse: THouse, time: Int) -> THouse {
//        let generalTime = time + oldHouse.timeExpenditure
//        let newHouse = storage.getHouses(time: generalTime).randomElement()
//        guard let newHouse = newHouse else { return oldHouse.copy(timeExpenditure: generalTime) }
//        return oldHouse.copy(image: newHouse.image, timeExpenditure: generalTime, width: newHouse.width)
//    }
}
