//
//  BuildingRepositoryNet.swift
//  TImeBurg
//
//  Created by Nebo on 17.02.2023.
//

import Foundation
import Combine

protocol BuildingRepositoryProtocol {
    func fetch() -> Future<[BuildingProtocol], Never>
}

class BuildingRepositoryNet: BuildingRepositoryProtocol {
    
    func fetch() -> Future<[BuildingProtocol], Never> {
        Future.init { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(5)) {
                promise(.success(
                [
                    BuildingStored(value: BuildingStored.initModel(image: "House1", width: 55, startTimeInterval: 80, endTimeInterval: 120)),
                    BuildingStored(value: BuildingStored.initModel(image: "House2", width: 30, startTimeInterval: 10, endTimeInterval: 60)),
                    BuildingStored(value: BuildingStored.initModel(image: "House3", width: 60, startTimeInterval: 100, endTimeInterval: 150)),
                    BuildingStored(value: BuildingStored.initModel(image: "House4", width: 60, startTimeInterval: 140, endTimeInterval: 200)),
                ] ))
            }
        }
    }
}
