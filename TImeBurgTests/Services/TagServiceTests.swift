//
//  TagServiceTests.swift
//  TImeBurgTests
//
//  Created by Nebo on 21.03.2023.
//
import XCTest
import Foundation
import Combine
import RealmSwift

@testable import TImeBurg

final class TagServiceTests: XCTestCase {
    
    private var cancellableSet: Set<AnyCancellable> = []
    var storageMock: StorageManagerMock!
    var repositoryNetMock: TagRepositoryMock!
    var sut: TagService!
    
    override func setUp() {
        storageMock = StorageManagerMock()
        repositoryNetMock = TagRepositoryMock()
        sut = TagService(storage: storageMock, net: repositoryNetMock)
    }
    
    override func tearDown() {
        sut = nil
        storageMock = nil
        repositoryNetMock = nil
    }
    
    
    func testSaveTagSuccess() {
        let tagName = "Test\(String(Int.random(in: 0...1000000)))"
        let expected = Tag(id: "000", name: tagName, color: "001122")
        let expectation = XCTestExpectation(description: "Your expectation")
        var actual: Tag?

        storageMock.setupGetObjects(objects: [TagStored(id: "000", name: tagName, color: "001122")] )
        sut.saveTag(tag: expected)

        sut.tags.sink {
            if !$0.isEmpty {
                actual = $0.first!
                expectation.fulfill()
            }
        }.store(in: &cancellableSet)

        wait(for: [expectation], timeout: 2.0)

        XCTAssertEqual(expected, actual)
    }
    
    func testUpdateTags() {
        let tagName = "Test\(String(Int.random(in: 0...1000000)))"
        let expected = [Tag(id: "000", name: tagName, color: "00")]
        let expectation = XCTestExpectation(description: "testUpdateTags")
        var actual: [Tag] = []
        
        repositoryNetMock.setUpFetchingTags(tags: [TagStored(id: "000", name: tagName, color: "00")] )

        
        sut.tags.sink {
            if !$0.isEmpty {
                actual = $0
                expectation.fulfill()
            }
        }.store(in: &cancellableSet)
        
        sut.fetch()
        storageMock.setupGetObjects(objects: [TagStored(id: "000", name: tagName, color: "00")] )
        
        wait(for: [expectation], timeout: 3.0)

        XCTAssertEqual(expected, actual)
    }
}

