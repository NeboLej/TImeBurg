//
//  Date +.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import Foundation

extension Date {
    
    func getOffsetDate(offset: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: offset, to: self) ?? Date()
    }

}
