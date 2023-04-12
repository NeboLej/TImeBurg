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
        guard let building = building else { return THouse(image: "House5", timeExpenditure: time, width: 50, line: 0, offsetX: calc(width: 30.0)) }
        let newHouse = THouse(image: building.image, timeExpenditure: time, width: building.width, line: 0, offsetX: 0)
        return newHouse
    }
    
    func calc(width: Double) -> Double {
        let screenWidth = Utilts.screenWidth
        
        let dd = Int(screenWidth/2)
        for x in stride(from: 0, to: dd, by: 5) {
            let interval = (Double(x) - width/2)...(Double(x) + width/2)
            
            if calc2(interval: (Double(x) - width/2)...(Double(x) + width/2)) {
                return Double(x)
            }
            
            if calc2(interval: (Double(-x) - width/2)...(Double(-x) + width/2)) {
                return Double(-x)
            }
        }
        return 0.0
    }
    
    func calc2(interval: ClosedRange<Double>) -> Bool {
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
