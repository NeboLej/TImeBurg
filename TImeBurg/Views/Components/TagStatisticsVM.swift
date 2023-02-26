//
//  TagStatisticsVM.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import Foundation

class TagStatisticsVM: ObservableObject {
    
    @Published var tags: [TagInfoVM] = []
    @Published var isAllTags = false
    @Published var isShowButton = true
    
    private let allTags: [TagInfoVM]
    
    init(history: [History]) {
        var dictTags: [Tag : Int] = [:]
        history.forEach {
            if dictTags[$0.tag] != nil {
                dictTags[$0.tag]! += $0.time
            } else {
                dictTags[$0.tag] = $0.time
            }
        }
        allTags = dictTags.map{ TagInfoVM(tag: TagVM(tag: $0.key), time: $0.value) }.sorted { $0.time > $1.time }
        isShowButton = allTags.count > 4
        tags = Array(allTags.prefix(4))
    }
    
    func showAll() {
        if isAllTags {
            tags = Array(allTags.prefix(4))
        } else {
            tags = allTags
        }
        isAllTags.toggle()
    }
}
