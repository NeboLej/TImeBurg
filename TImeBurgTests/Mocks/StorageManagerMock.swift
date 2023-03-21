//
//  StorageManagerMock.swift
//  TImeBurgTests
//
//  Created by Nebo on 19.02.2023.
//

@testable import TImeBurg

import Foundation
import RealmSwift

class StorageManagerMock: StoreManagerProtocol {

    private var getObjects: [Any] = []
    private var getObject: Any!
    
    func setupGetObjects(objects: [Any]) {
        getObjects = objects
    }
    
    func setupGetObject(object: Any) {
        getObject = object
    }
    
    func saveObjects<T>(_ objects: [T]) where T : Object {
        
    }
    
    func saveObject<T>(_ object: T) where T : Object {
        
    }
    
    func getObjects<T>(_ type: T.Type) -> [T] where T : Object {
        return getObjects as! [T]
    }
    
    func updateObject<T>(_ object: T) where T : Object {
        
    }
    
    func removeAllObjectsOfType<T>(_ type: T.Type) where T : Object {
        
    }
    
    func removeObject<T>(_ object: T) where T : Object {
        
    }
    
    func removeAll() {
        
    }
    
    func updateObject<T>(_ object: T) -> Bool where T : Object {
        true
    }
    
    func updateObjects<T>(_ objects: [T]) where T : Object {
        
    }
}
