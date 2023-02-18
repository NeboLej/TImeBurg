//
//  TServicesFactory.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import Foundation

protocol TServicesFactoryProtocol {
    var cityService: TCityServiceProtocol { get }
    var houseService: THouseServiceProtocol { get }
    var buildingService: BuildingServiceProtocol { get }
}

class TServicesFactory: TServicesFactoryProtocol {
    
    var cityService: TCityServiceProtocol
    var houseService: THouseServiceProtocol
    var buildingService: BuildingServiceProtocol
    
    init() {
        let storage = RealmManager()
        let buildingRepository = BuildingRepositoryNet()
        
        cityService = TCityService(storage: storage)
        houseService = THouseService(storage: storage)
        buildingService = BuildingService(storage: storage, net: buildingRepository)
    }
}
