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
                    BuildingStored(value: BuildingStored.initModel(image: "House2", width: 30, startTimeInterval: 0, endTimeInterval: 60)),
                    BuildingStored(value: BuildingStored.initModel(image: "House3", width: 60, startTimeInterval: 100, endTimeInterval: 150)),
                    BuildingStored(value: BuildingStored.initModel(image: "House4", width: 60, startTimeInterval: 140, endTimeInterval: 200)),
                    BuildingStored(value: BuildingStored.initModel(image: "House5", width: 65, startTimeInterval: 200, endTimeInterval: 250)),
                    BuildingStored(value: BuildingStored.initModel(image: "House6", width: 40, startTimeInterval: 50, endTimeInterval: 100)),
                    BuildingStored(value: BuildingStored.initModel(image: "House7", width: 30, startTimeInterval: 0, endTimeInterval: 60)),
                    BuildingStored(value: BuildingStored.initModel(image: "House8", width: 55, startTimeInterval: 120, endTimeInterval: 200)),
                ] ))
            }
        }
    }
}
