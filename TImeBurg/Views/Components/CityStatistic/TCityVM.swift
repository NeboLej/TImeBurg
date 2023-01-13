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
    @Published var numberOfBuildings: Int
    @Published var comfortRating: Double
    @Published var greenRating: Double
    
    init(name: String, numberOfPeople: Int, numberOfBuildings: Int, comfortRating: Double, greenRating: Double) {
        self.name = name
        self.numberOfPeople = numberOfPeople
        self.numberOfBuildings = numberOfBuildings
        self.comfortRating = comfortRating
        self.greenRating = greenRating
    }
    
    convenience init(city: TCity) {
        self.init(name: city.name, numberOfPeople: city.numberOfPeople, numberOfBuildings: city.numberOfBuildings, comfortRating: city.comfortRating, greenRating: city.greenRating)
    }
}

struct TCity {
    let name: String
    let numberOfPeople: Int
    let numberOfBuildings: Int
    let comfortRating: Double
    let greenRating: Double
}
