//
//  LifeCycleService.swift
//  TImeBurg
//
//  Created by Nebo on 12.05.2023.
//

import Foundation
import Combine

protocol LifeCycleServiceProtocol {
    var currentCity: CurrentValueSubject<Task?, Never> { get }
}

class LifeCycleService: BaseService, LifeCycleServiceProtocol {
    
    let storage: StoreManagerProtocol
    lazy var currentCity: CurrentValueSubject<Task?, Never> = { CurrentValueSubject<Task?, Never> ( nil ) }()
    
    init(storage: StoreManagerProtocol) {
        self.storage = storage
        super.init()
    }
}
