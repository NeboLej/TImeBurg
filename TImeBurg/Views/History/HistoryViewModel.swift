//
//  HistoryViewModel.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published var month = ["January 2023", "December 2022", "November 2022", "October 2022", "September 2022"]
    @Published var selectedMonth = 0 {
        didSet {
            tagStatisticsVM = TagStatisticsVM(history: Array(history.prefix(selectedMonth)))
        }
    }
    @Published var currentCity: TCityVM = TCityVM(city: .init(id: "122022", name: "December 2022", image: "testCity", spentTime: 123, comfortRating: 0.3, greenRating: 3.2, buildings: [], history: [:]))
    @Published var tagStatisticsVM: TagStatisticsVM
    var monthColors = ["218B82", "F7CE76", "C54E6C", "9AD9DB", "EF874D", "A15D98"]
    
    private var cities: [TCity] = []
    
    //TEST DATA
    private var history: [History] = [
        History(date: Date(), time: 120, tag: Tag(id: "qqq", name: "job", color: "C54E6C")),
        History(date: Date(), time: 20, tag: Tag(name: "reading", color: "EF874D")),
        History(date: Date().getOffsetDate(offset: -3), time: 120, tag: Tag(id: "eee", name: "painting", color: "F7CE76")),
        History(date: Date().getOffsetDate(offset: -1), time: 30, tag: Tag(id: "qqq", name: "job", color: "C54E6C")),
        History(date: Date().getOffsetDate(offset: -1), time: 200, tag: Tag(id: "eee", name: "painting", color: "F7CE76")),
        History(date: Date().getOffsetDate(offset: -1), time: 200, tag: Tag(id: "eee", name: "painting", color: "F7CE76")),
        History(date: Date().getOffsetDate(offset: -1), time: 200, tag: Tag(id: "rrr", name: "sdf", color: "9AD9DB")),
        History(date: Date().getOffsetDate(offset: -1), time: 33, tag: Tag(id: "ttt", name: "dcsdc", color: "F7CE76")),
        History(date: Date().getOffsetDate(offset: -1), time: 70, tag: Tag(id: "yyy", name: "vfdv", color: "A15D98")),
        History(date: Date().getOffsetDate(offset: -1), time: 22, tag: Tag(id: "uuu", name: "asd", color: "218B82")),
    ]
    
    init() {
        tagStatisticsVM = TagStatisticsVM(history: history)
    }
    
//    func getHistory() -> [History] {
//        Array(history.prefix(selectedMonth))
//    }
    
    func selectMonth(index: Int) {
        if selectedMonth != index{
            selectedMonth = index
        }
    }
    
    func getFullTime() -> String{
        let time = Array(history.prefix(selectedMonth)).reduce(0) { $0 + $1.time }
        let ch = time / 60 > 0 ? String("\(time / 60) h") : ""
        let min = time % 60 > 0 ? String("\(time % 60) min") : ""
        return "\(ch) \(min)"
    }
    
    func getHistory() -> [HistoryDayVM] {
        var result: [HistoryDayVM] = []
        let historyVM = Array(history.prefix(selectedMonth)).map{ HistoryVM(history: $0) }
        let dict1 = Dictionary(grouping: historyVM) { Calendar.current.dateComponents( [.year, .month, .day], from: $0.date) }
        
        dict1.forEach {
            result.append(HistoryDayVM(date: Calendar.current.date(from: $0.key)!, history: $0.value))
        }
        
        return result.sorted { $0.date >  $1.date }
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

class HistoryDayVM: ObservableObject, Identifiable {
    let id = UUID().uuidString
    @Published var date: Date
    @Published var history: [HistoryVM]
    
    init(date: Date, history: [HistoryVM]) {
        self.date = date
        self.history = history
    }
}

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
