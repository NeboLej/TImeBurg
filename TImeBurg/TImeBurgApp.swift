//
//  TImeBurgApp.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import SwiftUI

@main
struct TImeBurgApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @Environment(\.scenePhase) var scenePhase
    
    let serviceFactory: TServicesFactoryProtocol
    let lifeCycleServie: LifeCycleServiceProtocol
    
    init() {
        serviceFactory = TServicesFactory()
        lifeCycleServie = serviceFactory.lifeCycleService
    }
    
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnstatisfiable")
            let _ = print("BD---\(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)")
            TTabView(vm: TTabViewModel(servicesFactory: serviceFactory))
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
                case .background:
                    print("🔄--- App background")
                    lifeCycleServie.scenePhase.send(.background)
                case .inactive:
                    print("🔄--- App inactive")
                    lifeCycleServie.scenePhase.send(.inactive)
                case .active:
                    print("🔄--- App active")
                    lifeCycleServie.scenePhase.send(.active)
                @unknown default:
                    print("🔄--- App Error life cycle")
            }
        }
    }
}
