//
//  RealmManager.swift
//  TImeBurg
//
//  Created by Nebo on 15.02.2023.
//

import Foundation
import RealmSwift

protocol StoreManagerProtocol {
    func saveObjects<T>(_ objects: [T]) where T: Object
    func saveObject<T>(_ object: T) where T: Object
    
    func getObjects<T>(_ type: T.Type) -> [T] where T: Object
    //    func getObjects<T>(_ type: T.Type) -> Future<[T], Never> where T: Object
    func updateObject<T>(_ object: T) -> Bool where T: Object
    func updateObjects<T>(_ objects: [T]) where T: Object
    
    func removeAllObjectsOfType<T>(_ type: T.Type) where T: Object
    func removeObject<T>(_ object: T) where T: Object
    func removeAll()
    
    //    func updateObjects<T>(_ objects: [T]) throws where T: Object
    //    func removeObjects<T>(_ objects: [T]) where T: Object
    
}

//let config = Realm.Configuration(
//     schemaVersion: 1,
//        migrationBlock: { migration, oldSchemaVersion in
//        if (oldSchemaVersion < 1) {
//            // Nothing to do!
//            // Realm will automatically detect new properties and removed properties
//            // And will update the schema on disk automatically
//        }
//})
//Realm.Configuration.defaultConfiguration = config

class RealmManager: StoreManagerProtocol {
    
    private var realm: Realm?
    
    init() {
        print("---Realm--- created Realm in  \(Thread.current)")
        do {
            let config = Realm.Configuration(schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 4 { } } )
            Realm.Configuration.defaultConfiguration = config
            self.realm = try Realm()
        } catch {
            print("---Error opening Realm: \(error)")
        }
    }
    
    func saveObjects<T>(_ objects: [T]) where T : Object {
        print("---Realm--- save \(T.self) in \(Thread.current)")
        guard let realm = self.realm else { return }
        do {
            try realm.write {
                realm.add(objects)
            }
        } catch {
            print("---Error added to Realm: \(error)")
        }
    }
    
    func saveObject<T>(_ object: T) where T : Object {
        guard let realm = self.realm else { return }
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("---Error added to Realm: \(error)")
        }
    }
    
    func getObjects<T>(_ type: T.Type) -> [T] where T: Object {
        print("---Realm--- get \(T.self) in \(Thread.current)")
        guard let realm = try? Realm() else { return [] }
        let results = realm.objects(type)
        return Array(results)
    }
    
    func updateObject<T>(_ object: T) -> Bool where T: Object {
        print("---Realm--- update \(T.self) in  \(Thread.current)")
        guard let realm = self.realm else { return false }
        let result = realm.object(ofType: T.self, forPrimaryKey: object.value(forKeyPath: T.primaryKey()!) as? AnyObject)
        if result != nil
        {
            do {
                try realm.write {
                    realm.add(object, update: .modified)
                    return true
                }
            } catch {
                print("---Error updateObject to Realm: \(error)")
                return false
            }
        } else {
            print("---Error updateObject Realm: object result = nil")
            return false
        }
        return false
    }
    
    func updateObjects<T>(_ objects: [T]) where T: Object {
        objects.forEach { object in
            if !updateObject(object) {
                saveObject(object)
            }
        }
    }
    
    func removeObject<T>(_ object: T) where T: Object {
        print("---Realm--- deleted Object \(T.self) in  \(Thread.current)")
        guard let realm = self.realm else { return }
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("---Error removeObject to Realm: \(error)")
        }
    }
    
    func removeAllObjectsOfType<T>(_ type: T.Type) where T: Object {
        print("---Realm--- deleted type \(T.self) in  \(Thread.current)")
        guard let realm = self.realm else { return }
        do {
            try realm.write {
                realm.delete(realm.objects(T.self))
            }
        } catch {
            print("---Error removeAllObjectsOfType to Realm: \(error)")
        }
    }
    
    func removeAll() {
        print("---Realm--- deleted all in  \(Thread.current)")
        guard let realm = self.realm else { return }
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("---Error removeAll to Realm: \(error)")
        }
    }
    
    
    //    func updateObjects<T>(_ objects: [T]) throws where T : Object {
    //        <#code#>
    //    }
    //
    //    func removeObjects<T>(_ objects: [T]) where T : Object {
    //        <#code#>
    //    }
    //
}
