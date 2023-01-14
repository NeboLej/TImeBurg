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
    @Published var buildings: [String]
    
    init(name: String, numberOfPeople: Int, comfortRating: Double, greenRating: Double, buildings: [String]) {
        self.name = name
        self.numberOfPeople = numberOfPeople
        self.comfortRating = comfortRating
        self.greenRating = greenRating
        self.buildings = buildings
    }
    

    convenience init(city: TCity) {
        self.init(name: city.name, numberOfPeople: city.numberOfPeople, comfortRating: city.comfortRating, greenRating: city.greenRating, buildings: city.buildings)
    }
    
    func getUnicalBuildingsCount() -> Int {
        return 2
    }
    
    func getTopBuilding() -> String {
        return "House1"
    }
    
}
