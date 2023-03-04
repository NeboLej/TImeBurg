//
//  TCityVM.swift
//  TImeBurg
//
//  Created by Nebo on 13.01.2023.
//

import UIKit

class TCityVM: ObservableObject {
    var id: String
    @Published var name: String
    @Published var numberOfPeople: Int
    @Published var comfortRating: Double
    @Published var greenRating: Double
    @Published var buildings: [THouseVM] = []
    @Published var isCanEdit: Bool = false
    @Published var image: UIImage?
    
    init(id: String = "", name: String = "", numberOfPeople: Int = 0, comfortRating: Double = 0, greenRating: Double = 0, buildings: [THouse] = [], parent: Any? = nil) {
        let imageService = ImageService()
        self.id = id
        self.name = name
        self.numberOfPeople = numberOfPeople
        self.comfortRating = comfortRating
        self.greenRating = greenRating
        self.buildings = buildings.map { THouseVM(house: $0, parent: parent) }
        self.image = imageService.getImage(fileName: id)
    }
    
    convenience init(city: TCity, parent: Any? = nil) {
        self.init(id: city.id, name: city.name, numberOfPeople: Int(city.spentTime / 10), comfortRating: city.comfortRating, greenRating: city.greenRating, buildings: city.buildings, parent: parent)
    }
    
    func getUnicalBuildingsCount() -> Int {
        return 2
    }
    
    func getTopBuilding() -> THouseVM? {
        buildings.max { $0.timeExpenditure < $1.timeExpenditure }
    }
}
