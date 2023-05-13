//
//  TaskStored.swift
//  TImeBurg
//
//  Created by Nebo on 13.05.2023.
//

import Foundation

import Foundation
import RealmSwift

protocol TaskProtocol {
    var startTime: Date { get }
    var time: Int { get }
    var tagId: String { get }
    var houseId: String? { get }
}

class TaskStored: Object, TaskProtocol {
    @Persisted var startTime: Date
    @Persisted var time: Int
    @Persisted var tagId: String
    @Persisted var houseId: String? = nil
    
    static func initModel(startTime: Date, time: Int, tagId: String, houseId: String?) -> [String: Any?] {
        ["startTime": startTime, "time": time, "tagId": tagId, "houseId": houseId]
    }
    
    static func initModel(task: Task) -> [String: Any?] {
        ["startTime": task.startTime, "time": task.time, "tagId": task.tagId, "houseId": task.houseId]
    }
}
