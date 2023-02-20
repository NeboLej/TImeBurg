//
//  ImageServiceTests.swift
//  TImeBurgTests
//
//  Created by Nebo on 20.02.2023.
//

import XCTest
import UIKit
@testable import TImeBurg

final class ImageServiceTests: XCTestCase {
    
    var sut: ImageService!
    
    override func setUpWithError() throws {
        sut = ImageService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSaveImageSuccess() {
        
        let image = UIImage(systemName: "house")
        guard let image = image else { return }
        let imageName = "Test\(String(Int.random(in: 0...1000000)))"
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
        
        let resultMethod = sut.saveImage(imageName: imageName, image: image)
        
        XCTAssertEqual(resultMethod, fileURL.path)
        XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path))
    }
    
    func testSaveImageRemoveSuccess() {
        
        let image = UIImage(systemName: "house")
        guard let image = image else { return }
        let imageName = "Test\(String(Int.random(in: 0...1000000)))"
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
        
        _ = sut.saveImage(imageName: imageName, image: image)
        let resultMethod = sut.saveImage(imageName: imageName, image: image)
        let isFileExists = FileManager.default.fileExists(atPath: fileURL.path)
        
        XCTAssertEqual(resultMethod, fileURL.path)
        XCTAssertTrue(isFileExists)
    }
    
    func testRemoveImageSuccess() {
        
        let image = UIImage(systemName: "house")
        guard let image = image else { return }
        let imageName = "Test\(String(Int.random(in: 0...1000000)))"
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
        
        let resultSaveMethod = sut.saveImage(imageName: imageName, image: image)
        let resultRemoveMethod = sut.removeImage(path: fileURL.path)
        let isFileExists = FileManager.default.fileExists(atPath: fileURL.path)
        
        XCTAssertEqual(resultSaveMethod, fileURL.path)
        XCTAssertTrue(resultRemoveMethod)
        XCTAssertFalse(isFileExists)
    }
    
    func testRemoveImageError() {
        
        let imageName = "_Test\(String(Int.random(in: 0...1000000)))"
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
        
        let resultRemoveMethod = sut.removeImage(path: fileURL.path)
        let isFileExists = FileManager.default.fileExists(atPath: fileURL.path)
        
        XCTAssertFalse(resultRemoveMethod)
        XCTAssertFalse(isFileExists)
    }
    
    func testGetImageSuccess() {
        let image = UIImage(systemName: "house")
        guard let image = image else { return }
        let imageName = "Test\(String(Int.random(in: 0...1000000)))"
        
        let resultSaveMethod = sut.saveImage(imageName: imageName, image: image)
        XCTAssertTrue(!resultSaveMethod.isEmpty)
        
        let actual = sut.getImage(fileName: imageName)
        XCTAssertNotNil(actual)
    }
    
    func testGetImageNilImage() {
        let imageName = "_Test\(String(Int.random(in: 0...1000000)))"
        
        let actual = sut.getImage(fileName: imageName)
        XCTAssertNil(actual)
    }
}
