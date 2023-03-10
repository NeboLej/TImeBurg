//
//  THomeViewModel.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import Foundation
import UIKit
import Combine

class THomeViewModel: ObservableObject, THouseListenerProtocol, ProgressListener {

    @Published var activityType: TActivityType = .building
    @Published var timeActivity: Double = 10.0
    @Published var selectedHouse: THouseVM? { didSet { countPeople = selectedHouse?.timeExpenditure ?? 0 } }
    @Published var isProgress = false
    @Published var snapshotCity = false
    @Published var currentCityVM: TCityVM = TCityVM()
    @Published var tagsVM: [TagVM] = []
    @Published var countPeople: Int = 0
    @Published var cityCanEdit = false
    @Published var isShowMenu = false
    @Published var currentTag = 0
    
    let imageSet = ["Building", "Tree", "FixRoad"]
    
    private let cityService: TCityServiceProtocol
    private let serviceFactory: TServicesFactoryProtocol
    private let imageService: ImageServiceProtocol
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var currentCity: TCity?
    private var changedСity: TCity!
    private var tags: [Tag] = [] { didSet { tagsVM = tags.map{ TagVM(tag: $0) } } }
    
    init(serviceFactory: TServicesFactoryProtocol) {
        self.serviceFactory = serviceFactory
        cityService = serviceFactory.cityService
        imageService = ImageService()
        
        weak var _self = self
        
        cityService.currentCity
            .sink {
                _self?.currentCity = $0
                _self?.currentCityVM = TCityVM(city: $0, parent: _self)
            }
            .store(in: &cancellableSet)
        
        serviceFactory.tagService
            .tags
            .sink {
                _self?.tags = $0
            }
            .store(in: &cancellableSet)
        afterSnapshot()
    }
    
    func startActivity() -> TProgressVM {
        TProgressVM(minutes: Float(timeActivity), tag: tags[currentTag], serviceFactory: serviceFactory)
    }
    
    func saveImage(image: UIImage) {
        guard var city = currentCity else { return }
        let path = imageService.saveImage(imageName: city.id, image: image)
        if !path.isEmpty {
            city.image = path
            cityService.updateCurrentCity(city: city)
        }
    }
    
    func editCity() {
        cityCanEdit = true
        currentCityVM.isCanEdit = true
        changedСity = currentCity
    }
    
    func saveCity() {
        cityCanEdit = false
        currentCityVM.isCanEdit = false
        guard let city = changedСity else { return }
        cityService.updateCurrentCity(city: city)
        snapshotCity = true
    }
    
    func dontSaveCity() {
        cityCanEdit = false
        currentCityVM.isCanEdit = false
        changedСity = currentCity
    }
    
    func onClickCity() {
        if cityCanEdit {
            isShowMenu.toggle()
        }
        else if selectedHouse != nil {
            selectedHouse = nil
        } else {
            isShowMenu.toggle()
        }
    }
    
    //MARK: - THouseListenerProtocol
    func onHouseClick(id: String) {
        selectedHouse = nil
        let house = currentCityVM.buildings.first { $0.id == id }
        if let house = house {
            selectedHouse = house
        }
    }
    
    func onHouseMove(id: String, offsetX: CGFloat, line: Int) {
        let house = changedСity.buildings.first { $0.id == id }
        guard var house = house else { return }
        house.offsetX = offsetX
        house.line = line
        changedСity.buildings.removeAll(where: { $0.id == id } )
        changedСity.buildings.append(house)
    }
    
    func afterSnapshot() {
        weak var _self = self
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            _self?.snapshotCity = true
        }
    }
}
