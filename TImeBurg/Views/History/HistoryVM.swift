//
//  HistoryVM.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import Foundation

class HistoryVM: ObservableObject {
    @Published var month = ["January 2023", "December 2022", "November 2022", "October 2022", "September 2022"]
    @Published var selectedMonth = 0
    @Published var currentCity: TCityVM = TCityVM(city: .init(id: "122022", name: "December 2022", image: "testCity", spentTime: 123, comfortRating: 0.3, greenRating: 3.2, buildings: [], history: [:]))
    @Published var tagStatisticsVM: TagStatisticsVM
    var monthColors = ["218B82", "F7CE76", "C54E6C", "9AD9DB", "EF874D", "A15D98"]
    
    private var cities: [TCity] = []
    
    //TEST DATA
    private var history: [History] = [
        History(date: Date(), time: 120, tag: Tag(id: "qqq", name: "job", color: "C54E6C")),
        History(date: Date(), time: 20, tag: Tag(name: "reading", color: "EF874D")),
        History(date: Date().getOffsetDate(offset: -3), time: 120, tag: Tag(id: "eee", name: "painting", color: "F7CE76")),
        History(date: Date().getOffsetDate(offset: 1), time: 30, tag: Tag(id: "qqq", name: "job", color: "C54E6C")),
        History(date: Date().getOffsetDate(offset: 1), time: 200, tag: Tag(id: "eee", name: "painting", color: "F7CE76")),
        History(date: Date().getOffsetDate(offset: 1), time: 200, tag: Tag(id: "eee", name: "painting", color: "F7CE76")),
        History(date: Date().getOffsetDate(offset: 1), time: 200, tag: Tag(id: "rrr", name: "sdf", color: "9AD9DB")),
        History(date: Date().getOffsetDate(offset: 1), time: 33, tag: Tag(id: "ttt", name: "dcsdc", color: "F7CE76")),
        History(date: Date().getOffsetDate(offset: 1), time: 70, tag: Tag(id: "yyy", name: "vfdv", color: "A15D98")),
        History(date: Date().getOffsetDate(offset: 1), time: 22, tag: Tag(id: "uuu", name: "asd", color: "218B82")),
    ]
    
    init() {
        tagStatisticsVM = TagStatisticsVM(history: history)
    }
    
    func selectMonth(index: Int) {
        if selectedMonth != index{
            selectedMonth = index
        }
    }
}


struct TagInfoVM: Identifiable {
    let id: String
    let tag: TagVM
    let time: Int
    
    init(tag: TagVM, time: Int) {
        self.id = tag.id
        self.tag = tag
        self.time = time
    }
}
