//
//  HistoryVM.swift
//  TImeBurg
//
//  Created by Nebo on 04.03.2023.
//

import Foundation

class HistoryVM: ObservableObject, Identifiable {
    var id: String
    @Published var date:  Date
    @Published var time: Int
    @Published var tag: TagVM
    
    init(id: String, date: Date, time: Int, tag: TagVM, parent: Any? = nil) {
        self.id = id
        self.date = date
        self.time = time
        self.tag = tag
    }
    
    convenience init(history: History, parent: Any? = nil) {
        self.init(id: history.id, date: history.date, time: history.time, tag: TagVM(tag: history.tag))
    }
}
