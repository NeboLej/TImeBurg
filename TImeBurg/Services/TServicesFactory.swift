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
        let storage = TLocalStorageManager()
        
        cityService = TCityService(storage: storage)
        houseService = THouseService(storage: storage)
        
    }
}
