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
    private var cancellableSet: Set<AnyCancellable> = []

    
    init(storage: StoreManagerProtocol, net: HouseRepositoryProtocol) {
        self.storage = storage
        net.fetch()
//            .receive(on: DispatchQueue.main)
            .sink { buildings in
                print("вызываю перезапись в \(Thread.current)")
                self.rewriteBiuldings(buildings: buildings)
            }.store(in: &cancellableSet)
    }
    
    func getNewHouse(time: Int) -> THouse {
        let house = storage.getObjects(HouseStored.self).filter { ($0.startTimeInterval...$0.endTimeInterval).contains(time) }.randomElement()
        guard let house = house else { return THouse(image: "House2", timeExpenditure: time, width: 30, line: 0, offsetX: 0) }
        let newHouse = THouse(image: house.image, timeExpenditure: time, width: house.width, line: 0, offsetX: 0)
        return newHouse
    }
    
    func rewriteBiuldings(buildings: [HouseProtocol]) {
        let newBuildings = buildings.map { HouseStored(value: HouseStored.initModel(house: $0)) }
        if !newBuildings.isEmpty {
            storage.removeAllObjectsOfType(HouseStored.self)
            storage.saveObjects(newBuildings)
        }
    }
    
//    func upgradeHouse(oldHouse: THouse, time: Int) -> THouse {
//        let generalTime = time + oldHouse.timeExpenditure
//        let newHouse = storage.getHouses(time: generalTime).randomElement()
//        guard let newHouse = newHouse else { return oldHouse.copy(timeExpenditure: generalTime) }
//        return oldHouse.copy(image: newHouse.image, timeExpenditure: generalTime, width: newHouse.width)
//    }
}
