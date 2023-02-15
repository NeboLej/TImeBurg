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
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnstatisfiable")
            let _ = print("BD---\(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)")
            TTabView(vm: TTabViewModel(servicesFactory: serviceFactory))
        }
    }
}
