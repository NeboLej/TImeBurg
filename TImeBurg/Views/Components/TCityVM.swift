//
//  TCityVM.swift
//  TImeBurg
//
//  Created by Nebo on 13.01.2023.
//

import Foundation

class TCityVM: ObservableObject {
    @Published var name: String
    @Published var numberOfPeople: Int
    @Published var comfortRating: Double
    @Published var greenRating: Double
    @Published var buildings: [THouseVM] = []
    
    init(name: String, numberOfPeople: Int, comfortRating: Double, greenRating: Double, buildings: [THouse], parent: Any? = nil) {
        self.name = name
        self.numberOfPeople = numberOfPeople
        self.comfortRating = comfortRating
        self.greenRating = greenRating
        self.buildings = buildings.map { THouseVM(house: $0, parent: parent) }
    }
    
    convenience init(city: TCity, parent: Any? = nil) {
        self.init(name: city.name, numberOfPeople: city.numberOfPeople, comfortRating: city.comfortRating, greenRating: city.greenRating, buildings: city.buildings, parent: parent)
    }
    
    func getUnicalBuildingsCount() -> Int {
        return 2
    }
    
    func getTopBuilding() -> String {
        return "House1"
    }
    
}
