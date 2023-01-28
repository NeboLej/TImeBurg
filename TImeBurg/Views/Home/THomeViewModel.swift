//
//  THomeViewModel.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import Foundation
import Combine

class THomeViewModel: ObservableObject, THouseListenerProtocol {

    @Published var activityType: TActivityType = .building
    @Published var timeActivity: Double = 10.0
    @Published var isSetting1 = false
    @Published var isSetting2 = false
    @Published var selectedHouse: THouseVM? {
        didSet {
            countPeople = selectedHouse?.timeExpenditure ?? 0
        }
    }
    @Published var isProgress = false
    @Published var currentCity: TCityVM  = TCityVM()
    @Published var countPeople: Int = 0
    
    let imageSet = ["Building", "Tree", "FixRoad"]
    
    let citySetvice: TCityServiceProtocol
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(serviceFactory: TServicesFactoryProtocol) {
        citySetvice = serviceFactory.cityService
        
        weak var _self = self
        
        citySetvice.currentCity
            .sink {
                _self?.currentCity = TCityVM(city: $0, parent: _self)
            }
            .store(in: &cancellableSet)
    }
    
    func startActivity() -> TProgressVM {
        TProgressVM(minutes: Float(timeActivity))
    }
    
    func emptyClick() {
        selectedHouse = nil
    }
    
    //MARK: - THouseListenerProtocol
    func onHouseClick(id: String) {
        selectedHouse = nil
        let house = currentCity.buildings.first { $0.id == id }
        if let house = house {
            selectedHouse = house
//            count = house.timeExpenditure
        }
    }
}
