//
//  RealmManager.swift
//  TImeBurg
//
//  Created by Nebo on 15.02.2023.
//

import Foundation
import RealmSwift
import Combine

protocol StoreManagerProtocol {
    func saveObjects<T>(_ objects: [T]) where T: Object
    func saveObject<T>(_ object: T) where T: Object
    
    func getObjects<T>(_ type: T.Type) -> [T] where T: Object
//    func getObjects<T>(_ type: T.Type) -> Future<[T], Never> where T: Object
    func updateObject<T>(_ object: T) where T: Object
    
    func removeAllObjectsOfType<T>(_ type: T.Type) where T: Object
    func removeObject<T>(_ object: T) where T: Object
    func removeAll()
    
    //    func updateObjects<T>(_ objects: [T]) throws where T: Object
    //    func removeObjects<T>(_ objects: [T]) where T: Object
    
}

class RealmManager: StoreManagerProtocol {
    
    private var realm: Realm?
    private let realmQueue: DispatchQueue
    
    init(queue: DispatchQueue) {
        realmQueue = queue
        realmQueue.async {
            print("---Realm--- created Realm in  \(Thread.current)")
            do {
                let config = Realm.Configuration(schemaVersion: 2)
                Realm.Configuration.defaultConfiguration = config
                self.realm = try Realm(queue: self.realmQueue)
            } catch {
                print("---Error opening Realm: \(error)")
            }
        }
    }
    
    func saveObjects<T>(_ objects: [T]) where T : Object {
        realmQueue.async {
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
    
    func getObjects<T>(_ type: T.Type) -> Future<[T], Never> where T: Object {
        Future<[T], Never>.init { promise in
            self.realmQueue.async {
                guard let realm = self.realm else { return }
                let results = realm.objects(type)
                promise(.success(Array(results)))
            }
        }
        
//            print("достал из бд в \(Thread.current)")
//            guard let realm = try? Realm() else { return [] }
//            let results = realm.objects(type)
//            return Array(results)
    }
    
    func updateObject<T>(_ object: T) where T: Object {
        realmQueue.async {
            print("---Realm--- update \(T.self) in  \(Thread.current)")
            guard let realm = self.realm else { return }
            let result = realm.object(ofType: T.self, forPrimaryKey: object.value(forKeyPath: T.primaryKey()!) as? AnyObject)
            if result != nil
            {
                do {
                    try realm.write {
                        realm.add(object, update: .modified)
                    }
                } catch {
                    print("---Error updateObject to Realm: \(error)")
                }
            } else {
                print("---Error updateObject Realm: object result = nil")
            }
        }
    }
    
    func removeObject<T>(_ object: T) where T: Object {
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
        realmQueue.async {
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
