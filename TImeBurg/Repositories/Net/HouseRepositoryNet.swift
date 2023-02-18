//
//  HouseRepositoryNet.swift
//  TImeBurg
//
//  Created by Nebo on 17.02.2023.
//

import Foundation
import Combine

protocol HouseRepositoryProtocol {
    func fetch() -> Future<[HouseProtocol], Never>
}

class HouseRepositoryNet: HouseRepositoryProtocol {
    
    private let netQueue: DispatchQueue
    
    init(queue: DispatchQueue) {
        netQueue = queue
    }
    
    func fetch() -> Future<[HouseProtocol], Never> {
        Future.init { promise in
            self.netQueue.asyncAfter(deadline: .now() + .seconds(5)) {
                print("загружаю из сети в  \(Thread.current)")
                promise(.success(
                [
                    HouseStored(value: HouseStored.initModel(image: "House1", width: 55, startTimeInterval: 80, endTimeInterval: 120)),
                    HouseStored(value: HouseStored.initModel(image: "House2", width: 30, startTimeInterval: 10, endTimeInterval: 60)),
                ] ))
            }
        }
    }
}
