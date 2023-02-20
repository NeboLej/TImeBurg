//
//  THomeViewModel.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import Foundation
import UIKit
import Combine

class THomeViewModel: ObservableObject, THouseListenerProtocol {

    @Published var activityType: TActivityType = .building
    @Published var timeActivity: Double = 10.0
    @Published var isSetting1 = false
    @Published var isSetting2 = false
    @Published var selectedHouse: THouseVM? { didSet { countPeople = selectedHouse?.timeExpenditure ?? 0 } }
    @Published var isProgress = false
    @Published var snapshotCity = false
    @Published var currentCityVM: TCityVM = TCityVM()
    @Published var countPeople: Int = 0
    
    let imageSet = ["Building", "Tree", "FixRoad"]
    
    private let cityService: TCityServiceProtocol
    private let houseService: THouseServiceProtocol
    private let serviceFactory: TServicesFactoryProtocol
    private let imageService: ImageServiceProtocol
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var currentCity: TCity?
    
    init(serviceFactory: TServicesFactoryProtocol) {
        self.serviceFactory = serviceFactory
        cityService = serviceFactory.cityService
        houseService = serviceFactory.houseService
        imageService = ImageService()
        
        weak var _self = self
        
        cityService.currentCity
            .sink {
                _self?.currentCity = $0
                _self?.currentCityVM = TCityVM(city: $0, parent: _self)
            }
            .store(in: &cancellableSet)
    }
    
    func startActivity() -> TProgressVM {
        TProgressVM(minutes: Float(timeActivity), serviceFactory: serviceFactory)
    }
    
    func emptyClick() {
        selectedHouse = nil
    }
    
    func saveImage(image: UIImage) {
        guard var city = currentCity else { return }
        let path = imageService.saveImage(imageName: city.id, image: image)
        if !path.isEmpty {
            city.image = path
            cityService.updateCurrentCity(city: city)
        }
    }
    
    //MARK: - THouseListenerProtocol
    func onHouseClick(id: String) {
        snapshotCity = true //tmp
        selectedHouse = nil
        let house = currentCityVM.buildings.first { $0.id == id }
        if let house = house {
            selectedHouse = house
        }
    }
}
