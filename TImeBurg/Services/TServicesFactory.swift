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
        let dataQueue = DispatchQueue( label: "REALM" )
        let netQueue = DispatchQueue( label: "NET" )
        
        let storage = RealmManager(queue: dataQueue)
        let buildingRepository = BuildingRepositoryNet(queue: netQueue)
        
        cityService = TCityService(queue: dataQueue, storage: storage)
        houseService = THouseService(queue: dataQueue, storage: storage)
        buildingService = BuildingService(queue: dataQueue, storage: storage, net: buildingRepository)
    }
}
