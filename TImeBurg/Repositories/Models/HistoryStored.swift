//
//  HistoryStored.swift
//  TImeBurg
//
//  Created by Nebo on 04.03.2023.
//

import Foundation
import RealmSwift

protocol HistoryProtocol {
    var id: String { get }
    var date: Date { get }
    var time: Int { get }
    var tag: TagStored? { get }
}

class HistoryStored: Object, HistoryProtocol {
    @Persisted var id: String
    @Persisted var date: Date
    @Persisted var time: Int
    @Persisted var tag: TagStored? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func initModel(id: String, date: Date, time: Int, tag: TagStored) -> [String: Any] {
        ["id": id, "date": date, "time": time, "tag": tag]
    }
    
    static func initModel(history: History) -> [String: Any] {
        ["id": history.id, "date": history.date, "time": history.time, "tag": TagStored(value: TagStored.initModel(tag: history.tag))]
    }
}
