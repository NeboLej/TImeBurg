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
}

class TServicesFactory: TServicesFactoryProtocol {
    
    var cityService: TCityServiceProtocol
    var houseService: THouseServiceProtocol
    
    init() {
        let realmQueue = DispatchQueue( label: "REALM" )
        let netQueue = DispatchQueue( label: "NET" )
        
        let storage = RealmManager(queue: realmQueue)
        let houseRepository = HouseRepositoryNet(queue: netQueue)
        cityService = TCityService(storage: storage)
        houseService = THouseService(storage: storage, net: houseRepository)
    }
}
