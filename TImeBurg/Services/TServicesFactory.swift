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
    var tagService: TagServiceProtocol { get }
    var notificationService: NotificationServiceProtocol { get }
    var lifeCycleService: LifeCycleServiceProtocol { get }
}

class TServicesFactory: TServicesFactoryProtocol {
    
    var cityService: TCityServiceProtocol
    var houseService: THouseServiceProtocol
    var buildingService: BuildingServiceProtocol
    var tagService: TagServiceProtocol
    var notificationService: NotificationServiceProtocol
    var lifeCycleService: LifeCycleServiceProtocol
    
    init() {
        let storage = RealmManager()
        let buildingRepository = BuildingRepositoryNet()
        let tagRepository = TagRepositoryNet()
        let cityRepository = CityRepositoryNet()
        
        cityService = TCityService(storage: storage, net: cityRepository)
        houseService = THouseService(storage: storage, cityService: cityService)
        buildingService = BuildingService(storage: storage, net: buildingRepository)
        tagService = TagService(storage: storage, net: tagRepository)
        lifeCycleService = LifeCycleService(storage: storage)
        notificationService = NotificationService()
    }
}
