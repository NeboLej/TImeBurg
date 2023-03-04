//
//  History.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import Foundation

struct History: Identifiable, Equatable {
    let id: String
    let date: Date
    let time: Int
    let tag: Tag
    
    init(id: String = UUID().uuidString, date: Date, time: Int, tag: Tag) {
        self.id = id
        self.date = date
        self.time = time
        self.tag = tag
    }
    
    init(history: HistoryProtocol) {
        self.init(id: history.id, date: history.date, time: history.time, tag: Tag(tag: history.tag!))
    }
}
