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
    private var newHome: THouse? = nil
    private let tag: Tag
    
    private let houseService: THouseServiceProtocol
    private let cityService: TCityServiceProtocol
    private var parent: Any?
    
    init(minutes: Float, tag: Tag, serviceFactory: TServicesFactoryProtocol) {
        self.minutes = minutes
        self.tag = tag
        self.houseService = serviceFactory.houseService
        self.cityService = serviceFactory.cityService
    }
    
    func getTimerVM() -> TTimerVM {
        timerVM
    }
    
    func calcProgress(newValue: Float) {
        progress = 1.0 - ((100.0 / (minutes * 60)) * newValue)/100.0
    }
    
    func getHome() -> THouse {
        switch state {
            case .progress:
                return THouse(image: "House3", timeExpenditure: 0, width: 0, line: 0, offsetX: 0)
            case .completed:
                newHome = houseService.getNewHouse(time: Int(minutes))
                return newHome!
        }
    }
    
    func saveHouse() {
        cityService.updateCurrentCity(house: newHome!)
        cityService.updateCurrentCity(history: History(date: Date(), time: Int(minutes), tag: tag))
    }
    
    //MARK: TTimerListenerProtocol
    func timeRuns(seconds: Float) {
        calcProgress(newValue: seconds)
    }
    
    func timeFinish(on: Bool) {
        state = on ? .completed : .progress
    }
}
