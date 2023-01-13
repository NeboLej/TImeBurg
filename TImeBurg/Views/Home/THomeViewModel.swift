//
//  THomeViewModel.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import Foundation

class THomeViewModel: ObservableObject {
    
    @Published var activityType: TActivityType = .building
    @Published var timeActivity: Double = 10.0
    @Published var isSetting1 = false
    @Published var isSetting2 = false
    
    let imageSet = ["House1", "House2", "House3"]
    
    func StartActivity() {
        
    }
}
