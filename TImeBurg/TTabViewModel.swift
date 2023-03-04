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
    private let historyVM: HistoryViewModel
    
    init(servicesFactory: TServicesFactoryProtocol) {
        self.servicesFactory = servicesFactory
        homeVM = THomeViewModel(serviceFactory: servicesFactory)
        allCitiesVM = AllCitiesVM(serviceFactory: servicesFactory)
        historyVM = HistoryViewModel()
    }
    
    func getHomeViewModel() -> THomeViewModel {
        homeVM
    }
    
    func getAllCitiesViewModel() -> AllCitiesVM {
        allCitiesVM
    }
    
    func getHistoryViewModel() -> HistoryViewModel {
        historyVM
    }
    
}
enum Tab: String, CaseIterable {
    case list = "list.bullet.indent"
    case home = "house"
    case history = "book.closed"
    case gear = "gearshape"
}
