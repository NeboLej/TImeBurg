//
//  HouseStored.swift
//  TImeBurg
//
//  Created by Nebo on 15.02.2023.
//

import Foundation
import RealmSwift

class HouseStored: Object { 
    
    @Persisted var image: String
    @Persisted var width: Double
    @Persisted var startTimeInterval: Int
    @Persisted var endTimeInterval: Int
}
