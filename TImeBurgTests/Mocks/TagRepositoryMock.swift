//
//  TagRepositoryMock.swift
//  TImeBurgTests
//
//  Created by Nebo on 21.03.2023.
//

import Foundation
import Combine

@testable import TImeBurg

class TagRepositoryMock: TagRepositoryProtocol {
    
    private var tags: [TagProtocol] = []
    
    func setUpFetchingTags(tags: [TagProtocol]) {
        self.tags = tags
    }
    
    func fetch() -> Future<[TagProtocol], Never> {
        Future.init { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
                promise(.success(
                    self.tags.map {TagStored(id: $0.id, name: $0.name, color: $0.color) }
                ))
            }
        }
    }
}




