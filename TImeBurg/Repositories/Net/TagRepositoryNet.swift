//
//  TagRepositoryNet.swift
//  TImeBurg
//
//  Created by Nebo on 04.03.2023.
//

import Foundation
import Combine

protocol TagRepositoryProtocol {
    func fetch() -> Future<[TagProtocol], Never>
}

class TagRepositoryNet: TagRepositoryProtocol {
    
    func fetch() -> Future<[TagProtocol], Never> {
        Future.init { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(5)) {
                promise(.success(
                [
                    TagStored(value: TagStored.initModel(id: "5955A022-C27D-4CD9-8917-D90AF706962B", name: "Job", color: "218B82")),
                    TagStored(value: TagStored.initModel(id: "7D046DA5-89AA-4052-BD5E-A7D2ED00BED3", name: "Reading", color: "F96161")),
                    TagStored(value: TagStored.initModel(id: "8AD3BDA9-DB33-40D5-A5F5-287D08E1031F", name: "Programing", color: "F7CE76")),
                    TagStored(value: TagStored.initModel(id: "2F982C56-A9F2-4A88-BFC7-838C74EC7CAF", name: "Studies", color: "A15D98"))
                ]))
            }
        }
    }
}
