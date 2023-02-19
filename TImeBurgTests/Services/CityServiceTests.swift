//
//  CityServiceTests.swift
//  TImeBurgTests
//
//  Created by Nebo on 19.02.2023.
//

import XCTest
import Combine

@testable import TImeBurg

class CityServiceTests: XCTestCase {
    
    private var cancellableSet: Set<AnyCancellable> = []
    var storageMock: StorageManagerMock!
    var sut: TCityService!
    
    override func setUp() {
        storageMock = StorageManagerMock()
        sut = TCityService(storage: storageMock)
    }
    
    override func tearDown() {
        sut = nil
        storageMock = nil
    }
    
    func testGetCityPreviewsSuccess() {
        var actual: [TCityPreview] = []

        storageMock.setupGetObjects(objects: [
            CityStored(id: "1111", name: "Test", image: "", spentTime: 123, comfortRating: 0, greenRating: 0, buildings: [])
        ])
        
        let sut = TCityService(storage: storageMock)
        sut.cityPreviews.sink { actual = $0 }.store(in: &cancellableSet)

        let expected = [TCityPreview(id: "1111", name: "Test", image: "", spentTime: 123)]

        XCTAssertEqual(expected, actual)
    }
    
    func testGetCityPreviewsEmpty() {
        var actual: [TCityPreview] = []
        
        sut.cityPreviews.sink { actual = $0 }.store(in: &cancellableSet)

        XCTAssertTrue(actual.isEmpty)
    }
    
    func testGetCurrentCity() {
        
        var actual: TCity!
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        
        let cityId = "\(month)\(year)"
        let expectedCity = TCity(id: cityId, name: "December", image: "eee", spentTime: 123, comfortRating: 0.0, greenRating: 0.1, buildings: [], history: [:])
        storageMock.setupGetObjects(objects: [CityStored(id: cityId, name: "December", image: "eee", spentTime: 123, comfortRating: 0.0, greenRating: 0.1, buildings: [])])
        
        let sut = TCityService(storage: storageMock)
        sut.currentCity.sink { actual = $0 }.store(in: &cancellableSet)

        XCTAssertEqual(actual, expectedCity)
    }
    
    func testGetCurrentCityNewCity() {
        
        var actual: TCity!
        let year = Calendar.current.component(.year, from: Date())
        
        let month = Calendar.current.component(.month, from: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL YYYY"
        
        let cityId = "\(month)\(year)"
        let expectedCity = TCity(id: cityId, name: formatter.string(from: Date()), image: "", spentTime: 0, comfortRating: 0, greenRating: 0, buildings: [], history: [:])
        storageMock.setupGetObjects(objects: [])
        
        let sut = TCityService(storage: storageMock)
        sut.currentCity.sink { actual = $0 }.store(in: &cancellableSet)

        XCTAssertEqual(actual, expectedCity)
    }
    
    func testUpdateCurrentCity() {
        
        let expectedHouse = THouse(image: "House", timeExpenditure: 123, width: 50, line: 1, offsetX: 49)
        var actual: TCity!
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        
        let cityId = "\(month)\(year)"
        
        storageMock.setupGetObjects(objects: [CityStored(id: cityId, name: "December", image: "eee", spentTime: 123, comfortRating: 0.0, greenRating: 0.1, buildings: [])])
        
        let sut = TCityService(storage: storageMock)
        sut.currentCity.sink { actual = $0 }.store(in: &cancellableSet)
        
        sut.updateCurrentCity(house: expectedHouse)
        
        XCTAssertTrue(actual.buildings.contains(where: { $0 == expectedHouse}))
    }
    
}
