//
//  TImeBurgApp.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import SwiftUI

@main
struct TImeBurgApp: App {
    
    let serviceFactory: TServicesFactoryProtocol
    
    init() {
        serviceFactory = TServicesFactory()
    }
    
    var body: some Scene {
        WindowGroup {
            TTabView(vm: TTabViewModel(servicesFactory: serviceFactory))
        }
    }
}
