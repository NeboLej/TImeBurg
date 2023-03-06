//
//  HistoryDayVM.swift
//  TImeBurg
//
//  Created by Nebo on 04.03.2023.
//

import Foundation

class HistoryDayVM: ObservableObject, Identifiable {
    let id = UUID().uuidString
    @Published var date: Date
    @Published var history: [HistoryVM]
    @Published var fullTime: String = ""
    
    init(date: Date, history: [HistoryVM]) {
        self.date = date
        self.history = history
        let time = history.reduce(0) { $0 + $1.time }
        let ch = time / 60 > 0 ? String("\(time / 60) h") : ""
        let min = time % 60 > 0 ? String("\(time % 60) min") : ""
        fullTime = "\(ch) \(min)"
    }
}
