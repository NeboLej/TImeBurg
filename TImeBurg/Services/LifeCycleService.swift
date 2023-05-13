//
//  LifeCycleService.swift
//  TImeBurg
//
//  Created by Nebo on 12.05.2023.
//

import Foundation
import Combine

protocol LifeCycleServiceProtocol {
    var currentTask: CurrentValueSubject<Task?, Never> { get }
    var scenePhase: CurrentValueSubject<LifeCycleType, Never> { get }
    
    func startTask(task: Task)
    func endTask()
}

class LifeCycleService: BaseService, LifeCycleServiceProtocol {
    
    let storage: StoreManagerProtocol
    lazy var currentTask: CurrentValueSubject<Task?, Never> = { CurrentValueSubject<Task?, Never>( nil ) }()
    lazy var scenePhase: CurrentValueSubject<LifeCycleType, Never> = { CurrentValueSubject<LifeCycleType, Never>( .inactive ) }()
    
    init(storage: StoreManagerProtocol) {
        self.storage = storage
        super.init()
    }
    
    func startTask(task: Task) {
        let taskStored = TaskStored(value: TaskStored.initModel(task: task))
        storage.saveObject(taskStored)
        getTask()
    }
    
    func endTask() {
        storage.removeAllObjectsOfType(TaskStored.self)
        getTask()
    }
    
    private func getTask() {
        let tasks = storage.getObjects(TaskStored.self).map { Task(startTime: $0.startTime, time: $0.time, tagId: $0.tagId, houseId: $0.houseId) }
        currentTask.send(tasks.first)
    }
}
