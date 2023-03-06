//
//  TagStored.swift
//  TImeBurg
//
//  Created by Nebo on 04.03.2023.
//

import Foundation
import RealmSwift

protocol TagProtocol {
    var id: String { get }
    var name: String { get }
    var color: String { get }
}

class TagStored: Object, TagProtocol {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var color: String
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func initModel(id: String = UUID().uuidString, name: String, color: String) -> [String: Any] {
        ["id": id, "name": name, "color": color]
    }
    
    static func initModel(tag: TagProtocol) -> [String: Any] {
        ["id": tag.id, "name": tag.name, "color": tag.color]
    }
}
