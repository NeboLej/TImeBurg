//
//  AllCitiesVM.swift
//  TImeBurg
//
//  Created by Nebo on 02.02.2023.
//

import Foundation
import Combine

class AllCitiesVM: ObservableObject {
    @Published var citiesPreview: [TCityPreviewVM] = []
    
    private let cityService: TCityServiceProtocol
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(serviceFactory: TServicesFactoryProtocol) {
        cityService = serviceFactory.cityService
        weak var _self = self
        
        cityService.cityPreviews
            .sink {
                _self?.citiesPreview = $0.map { TCityPreviewVM(city: $0, parent: _self)}.reversed()
            }
            .store(in: &cancellableSet)
    }
}
