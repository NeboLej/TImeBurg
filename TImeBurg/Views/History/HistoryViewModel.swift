//
//  HistoryViewModel.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import Foundation
import Combine

class HistoryViewModel: ObservableObject {
    @Published var month: [String] = []
    @Published var selectedMonth: Int { didSet { updatePage(monthIndex: selectedMonth) } }
    @Published var currentCity: TCityVM = TCityVM()
    @Published var tagStatisticsVM: TagStatisticsVM
    var monthColors = ["218B82", "F7CE76", "C54E6C", "9AD9DB", "EF874D", "A15D98"]

    private var history: [History] = [
        //TEST DATA
//        History(date: Date(), time: 120, tag: Tag(id: "qqq", name: "job", color: "C54E6C")),
//        History(date: Date(), time: 20, tag: Tag(name: "reading", color: "EF874D")),
//        History(date: Date().getOffsetDate(offset: -3), time: 120, tag: Tag(id: "eee", name: "painting", color: "F7CE76")),
//        History(date: Date().getOffsetDate(offset: -1), time: 30, tag: Tag(id: "qqq", name: "job", color: "C54E6C")),
//        History(date: Date().getOffsetDate(offset: -1), time: 200, tag: Tag(id: "eee", name: "painting", color: "F7CE76")),
//        History(date: Date().getOffsetDate(offset: -1), time: 200, tag: Tag(id: "eee", name: "painting", color: "F7CE76")),
//        History(date: Date().getOffsetDate(offset: -1), time: 200, tag: Tag(id: "rrr", name: "sdf", color: "9AD9DB")),
//        History(date: Date().getOffsetDate(offset: -1), time: 33, tag: Tag(id: "ttt", name: "dcsdc", color: "F7CE76")),
//        History(date: Date().getOffsetDate(offset: -1), time: 70, tag: Tag(id: "yyy", name: "vfdv", color: "A15D98")),
//        History(date: Date().getOffsetDate(offset: -1), time: 22, tag: Tag(id: "uuu", name: "asd", color: "218B82")),
    ]
    
    private var cities: [TCity]
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(serviceFactory: TServicesFactoryProtocol) {
        tagStatisticsVM = TagStatisticsVM(history: history)
        cities = serviceFactory.cityService.fetch()
        selectedMonth = 0
        weak var _self = self
        
        month = cities.map { $0.name }
        
        serviceFactory.cityService.currentCity
            .sink {
                _self?.cities[0] = $0
                _self?.updatePage(monthIndex: self.selectedMonth)
            }
            .store(in: &cancellableSet)
    }
    
    func selectMonth(index: Int) {
        if selectedMonth != index{
            selectedMonth = index
        }
    }
    
    func getFullTime() -> String{
        let time = history.reduce(0) { $0 + $1.time }
        let ch = time / 60 > 0 ? String("\(time / 60) h") : ""
        let min = time % 60 > 0 ? String("\(time % 60) min") : ""
        return "\(ch) \(min)"
    }
    
    func getHistory() -> [HistoryDayVM] {
        var result: [HistoryDayVM] = []
        let historyVM = history.map{ HistoryVM(history: $0) }
        let dict = Dictionary(grouping: historyVM) { Calendar.current.dateComponents( [.year, .month, .day], from: $0.date) }
        
        dict.forEach {
            result.append(HistoryDayVM(date: Calendar.current.date(from: $0.key)!, history: $0.value))
        }
        
        return result.sorted { $0.date >  $1.date }
    }
    
    func updatePage(monthIndex: Int) {
        weak var _self = self
        history = cities[selectedMonth].history
        tagStatisticsVM = TagStatisticsVM(history: history)
        currentCity = TCityVM(city: cities[selectedMonth], parent: _self)
    }
    
    func getMonthColor(index: Int) -> String {
        monthColors[index % monthColors.count]
    }
}
