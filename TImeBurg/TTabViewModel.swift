//
//  TTabViewModel.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import Foundation

class TTabViewModel: ObservableObject {
    
    let servicesFactory: TServicesFactoryProtocol
    
    init(servicesFactory: TServicesFactoryProtocol) {
        self.servicesFactory = servicesFactory
    } 
}
