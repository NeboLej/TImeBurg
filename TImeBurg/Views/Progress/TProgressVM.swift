//
//  TProgressVM.swift
//  TImeBurg
//
//  Created by Nebo on 23.01.2023.
//

import Foundation

class TProgressVM: ObservableObject, TTimerListenerProtocol {
  
    enum State {
        case progress, completed
    }
    
    @Published var minutes: Float
    @Published var state: State = .progress
    @Published var progress: Float = 0.0
    
    private lazy var timerVM: TTimerVM = TTimerVM(minutes: minutes, parent: self)
    private var newHouse: THouse? = nil
    private let tag: Tag
    
    private let houseService: THouseServiceProtocol
    private let cityService: TCityServiceProtocol
    private let lifeCycleService: LifeCycleServiceProtocol
    private var parent: Any?
    private let upgradedHouse: THouse?
    
    init(minutes: Float, tag: Tag, upgradedHouse: THouse?, serviceFactory: TServicesFactoryProtocol) {
        self.minutes = minutes
        self.tag = tag
        self.upgradedHouse = upgradedHouse
        self.houseService = serviceFactory.houseService
        self.cityService = serviceFactory.cityService
        self.lifeCycleService = serviceFactory.lifeCycleService
    }
    
    func getTimerVM() -> TTimerVM {
        timerVM
    }
    
    func calcProgress(newValue: Float) {
        progress = 1.0 - ((100.0 / (minutes * 60)) * newValue)/100.0
    }
    
    func getHome() -> THouse {
        newHouse = upgradedHouse == nil ? houseService.getNewHouse(time: Int(minutes)) : houseService.upgradeHouse(oldHouse: upgradedHouse!, time: Int(minutes))
        return newHouse!
    }
    
    func saveHouse() {
        cityService.updateCurrentCity(house: newHouse!)
        cityService.updateCurrentCity(history: History(date: Date(), time: Int(minutes), tag: tag))
        lifeCycleService.endTask()
    }
    
    //MARK: TTimerListenerProtocol
    func timeRuns(seconds: Float) {
        calcProgress(newValue: seconds)
    }
    
    func timeFinish(on: Bool) {
        state = on ? .completed : .progress
    }
}
