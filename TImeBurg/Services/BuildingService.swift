//
//  BuildingService.swift
//  TImeBurg
//
//  Created by Nebo on 18.02.2023.
//

import Foundation
import Combine

protocol BuildingServiceProtocol {
    
}

class BuildingService: BuildingServiceProtocol {
    
    private let storage: StoreManagerProtocol
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(storage: StoreManagerProtocol, net: BuildingRepositoryProtocol) {
        self.storage = storage
        net.fetch()
            .receive(on: DispatchQueue.main)
            .sink { buildings in
                self.rewriteBiuldings(buildings: buildings)
            }.store(in: &cancellableSet)
    }
    
    private func rewriteBiuldings(buildings: [BuildingProtocol]) {
        let newBuildings = buildings.map { BuildingStored(value: BuildingStored.initModel(house: $0)) }
        if !newBuildings.isEmpty {
            storage.removeAllObjectsOfType(BuildingStored.self)
            storage.saveObjects(newBuildings)
        }
    }
    
}
