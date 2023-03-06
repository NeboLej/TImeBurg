//
//  TagInfoVM.swift
//  TImeBurg
//
//  Created by Nebo on 04.03.2023.
//

import Foundation


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
