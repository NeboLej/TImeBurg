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
    var fullTime: Int = 0// { tags.reduce(0) { $0 + $1.time } }
    
    private let maxTags = 4
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
        isShowButton = allTags.count > maxTags
        fullTime = allTags.reduce(0) { $0 + $1.time }
        tags = Array(allTags.prefix(maxTags))
        if allTags.count >=  maxTags {
            tags.append(TagInfoVM(tag: TagVM(name: "Other", color: .white), time: fullTime - tags.reduce(0) { $0 + $1.time }))
        }
    }
    
    func showAll() {
        if isAllTags {
            tags = Array(allTags.prefix(maxTags))
            tags.append(TagInfoVM(tag: TagVM(name: "other", color: .white), time: fullTime - tags.reduce(0) { $0 + $1.time }))
        } else {
            tags = allTags
        }
        isAllTags.toggle()
    }
}
