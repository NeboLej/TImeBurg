//
//  LifeCycleService.swift
//  TImeBurg
//
//  Created by Nebo on 12.05.2023.
//

import Foundation
import Combine

protocol LifeCycleServiceProtocol {
    var currentTask: PassthroughSubject<Task?, Never> { get }
    var scenePhase: PassthroughSubject<LifeCycleType, Never> { get }
    
    func startTask(task: Task)
    func endTask()
}

class LifeCycleService: BaseService, LifeCycleServiceProtocol {
    
    let storage: StoreManagerProtocol
    var currentTask = PassthroughSubject<Task?, Never>()
    var scenePhase = PassthroughSubject<LifeCycleType, Never>()
    
    init(storage: StoreManagerProtocol) {
        self.storage = storage
        super.init()
        
        scenePhase.sink { phase in
            if phase == .foreground {
                self.getTask()
            }
        }
        .store(in: &cancellableSet)
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
        let tasks = storage.getObjects(TaskStored.self)
            .map { Task(startTime: $0.startTime, time: $0.time, tagId: $0.tagId, houseId: $0.houseId) }
        currentTask.send(tasks.first)
    }
}
