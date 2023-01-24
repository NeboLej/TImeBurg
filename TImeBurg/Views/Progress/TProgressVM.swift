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
    
    init(minutes: Float) {
        self.minutes = minutes
    }
    
    func getTimerVM() -> TTimerVM {
        timerVM
    }
    
    func calcProgress(newValue: Float) {
        progress = 1.0 - ((100.0 / (minutes * 60)) * newValue)/100.0
    }
    
    func getHome() -> THouseVM {
        THouseVM(house: THouse(image: "House3", timeExpenditure: Int(minutes), width: 60, line: 0, offsetX: 0))
    }
    
    //MARK: TTimerListenerProtocol
    func timeRuns(seconds: Float) {
        calcProgress(newValue: seconds)
    }
    
    func timeFinish(on: Bool) {
        state = on ? .completed : .progress
    }
}
