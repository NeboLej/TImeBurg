//
//  THomeViewModel.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import Foundation

class THomeViewModel: ObservableObject, THouseListener {

    @Published var activityType: TActivityType = .building
    @Published var timeActivity: Double = 10.0
    @Published var isSetting1 = false
    @Published var isSetting2 = false
    @Published var selectedHouse: THouseVM?
    @Published var selectedHouseCount: Int = 0
    private let buildings = [
        THouse(image: "House1", timeExpenditure: 60, width: 60, line: 0, offsetX: -0),
        THouse(image: "House2", timeExpenditure: 10, width: 35, line: 0, offsetX: -60),
        THouse(image: "House3", timeExpenditure: 160, width: 60, line: 0, offsetX: -120),
        THouse(image: "House4", timeExpenditure: 60, width: 65, line: 0, offsetX: 150),
    ]
    
    let imageSet = ["House1", "House2", "House3"]
    
    func startActivity() {
        
    }
    
    func getCurrentCity() -> TCityVM {

        
        return TCityVM(city: TCity(name: "Челябинск", numberOfPeople: 431, comfortRating: 0.8, greenRating: 1.9, buildings: buildings), parent: self)
    }
    
    func onHouseClick(id: String) {
        selectedHouse = nil
        let house = buildings.first { $0.id == id }
        if let house = house {
            selectedHouse = THouseVM(house: house)
            selectedHouseCount = 50
        }
    }
    
    func emptyClick() {
        selectedHouse = nil
    }
    
    func getPeopleCount() -> Int {
        guard let house = selectedHouse else { return 0 }
        return house.timeExpenditure / 10
    }
}
