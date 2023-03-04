//
//  History.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import Foundation

struct History: Identifiable {
    let id: String = UUID().uuidString
    let date: Date
    let time: Int
    let tag: Tag
}
