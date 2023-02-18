//
//  TTabViewModel.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import Foundation

class TTabViewModel: ObservableObject {
    
    let servicesFactory: TServicesFactoryProtocol
    @Published var currentTab: Tab = .home
    
    init(servicesFactory: TServicesFactoryProtocol) {
        self.servicesFactory = servicesFactory
    }
}
enum Tab: String, CaseIterable {
    case list = "list.bullet.indent"
    case home = "house"
    case gear = "gearshape"
}
