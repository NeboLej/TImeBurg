//
//  CityRepositoryNet.swift
//  TImeBurg
//
//  Created by Nebo on 09.04.2023.
//

import Foundation

protocol CityRepositoryProtocol {
    func getBackgroundImages() -> [String]
}

class CityRepositoryNet: CityRepositoryProtocol {
    private let backroundImages = ["bg5", "bg6", "bg9", "bg10", "bg11", "bg12", "bg13", "bg14", "bg15", "bg16", "bg17", "bg18"]
    
    func getBackgroundImages() -> [String] {
        backroundImages
    }
}
