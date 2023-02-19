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
    private let homeVM: THomeViewModel
    private let allCitiesVM: AllCitiesVM
    
    init(servicesFactory: TServicesFactoryProtocol) {
        self.servicesFactory = servicesFactory
        homeVM = THomeViewModel(serviceFactory: servicesFactory)
        allCitiesVM = AllCitiesVM(serviceFactory: servicesFactory)
    }
    
    func getHomeViewModel() -> THomeViewModel {
        homeVM
    }
    
    func getAllCitiesViewModel() -> AllCitiesVM {
        allCitiesVM
    }
    
}
enum Tab: String, CaseIterable {
    case list = "list.bullet.indent"
    case home = "house"
    case gear = "gearshape"
}
