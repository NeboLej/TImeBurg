//
//  Date +.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import Foundation

fileprivate let SIMPLE_FMT: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateFormat = "dd.MM.yyyy"
    return fmt
}()

fileprivate let DATE_FULL_FMT: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateFormat = "dd MMMM"
    return fmt
}()

fileprivate let DATE_FULL_YEAR_FMT: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateFormat = "dd MMMM yyyy"
    return fmt
}()

extension Date {
    
    var nextDay: Date { Date(timeIntervalSince1970: timeIntervalSince1970 + 60*60*24) }
    var prevDay: Date { Date(timeIntervalSince1970: timeIntervalSince1970 - 60*60*24) }
    
    func getOffsetDate(offset: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: offset, to: self) ?? Date()
    }
    
    func toReadableDate() -> String {
        let date = Date()
        if IsSameDay( with: date ) { return "Сегодня" }
        else if IsSameDay( with: date.nextDay ) { return "Завтра" }
        else if IsSameDay( with: date.prevDay ) { return "Вчера" }
        else { return SIMPLE_FMT.string( from: self ) }
    }
    
    func IsSameDay(with: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: with)
    }
    
    func IsSameYear( with: Date ) -> Bool {
        let comp0 = Calendar.current.dateComponents([.era, .year], from: self)
        let comp1 = Calendar.current.dateComponents([.era, .year], from: with)
        return comp0.era == comp1.era && comp0.year == comp1.year
    }
}
