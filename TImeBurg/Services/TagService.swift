//
//  TagService.swift
//  TImeBurg
//
//  Created by Nebo on 04.03.2023.
//

import Foundation
import Combine

protocol TagServiceProtocol {
    var tags: CurrentValueSubject<[Tag], Never> { get }
    func fetch()
    func saveTag(tag: Tag)
}

class TagService: BaseService, TagServiceProtocol {
    
    let net: TagRepositoryProtocol
    let storage: StoreManagerProtocol
    let tags = CurrentValueSubject<[Tag], Never>([])
    
    init(storage: StoreManagerProtocol, net: TagRepositoryProtocol) {
        self.storage = storage
        self.net = net
        super.init()
        
        getTags()
        fetch()
    }
    
    func fetch() {
        net.fetch()
            .receive(on: DispatchQueue.main)
            .sink { tags in
                self.updateTags(tags: tags)
            }.store(in: &cancellableSet)
        getTags()
    }
    
    func saveTag(tag: Tag) {
        let tagStored = TagStored(value: TagStored.initModel(tag: tag))
        storage.saveObject(tagStored)
        getTags()
    }
    
    private func updateTags(tags: [TagProtocol]) {
        let newTags = tags.map { TagStored(value: TagStored.initModel(tag: $0)) }
        if !newTags.isEmpty {
            storage.updateObjects(newTags)
        }
        getTags()
    }
    
    private func getTags() {
        let newTags = storage.getObjects(TagStored.self).map { Tag(id: $0.id, name: $0.name, color: $0.color) }
        tags.send(newTags)
    }
}
