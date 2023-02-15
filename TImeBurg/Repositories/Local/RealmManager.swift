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
    func updateObject<T>(_ object: T) where T: Object
    
    //    func updateObjects<T>(_ objects: [T]) throws where T: Object
    //    func removeObjects<T>(_ objects: [T]) where T: Object
    //    func removeObject<T>(_ object: T) where T: Object
    //    func removeAllObjectsOfType<T>(_ type: T.Type) where T: Object
    //    func removeAll()
}

class RealmManager: StoreManagerProtocol {
    
    private var realm: Realm?
    
    init() {
        do {
            let config = Realm.Configuration(schemaVersion: 2)
            Realm.Configuration.defaultConfiguration = config
            realm = try Realm()
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
    
    func saveObjects<T>(_ objects: [T]) where T : Object {
        if let realm = realm {
            do {
                try realm.write {
                    realm.add(objects)
                }
            } catch {
                print("Error added to Realm: \(error)")
            }
        }
    }
    
    func saveObject<T>(_ object: T) where T : Object {
        if let realm = realm {
            do {
                try realm.write {
                    realm.add(object)
                }
            } catch {
                print("Error added to Realm: \(error)")
            }
        }
    }
    
    func getObjects<T>(_ type: T.Type) -> [T] where T: Object {
        guard let realm = try? Realm() else { return [] }
        let results = realm.objects(type)
        return Array(results)
    }
    
    func updateObject<T>(_ object: T) where T: Object {
        if let realm = realm {
            let result = realm.object(ofType: T.self, forPrimaryKey: object.value(forKeyPath: T.primaryKey()!) as? AnyObject)
            if result != nil
            {
                do {
                    try realm.write {
                        realm.add(object, update: .modified)
                    }
                } catch {
                    print("Error update to Realm: \(error)")
                }
            } else {
                print("Error update to Realm: object result = nil")
            }
        }
    }
    
    
    //    func getObjects<T>(_ type: T.Type, predicate: NSPredicate) -> [T]? where T : Object {
    //        <#code#>
    //    }
    //
    //    func updateObjects<T>(_ objects: [T]) throws where T : Object {
    //        <#code#>
    //    }
    //
    //    func updateObject<T>(_ object: T) throws where T : Object {
    //        <#code#>
    //    }
    //
    //    func removeObjects<T>(_ objects: [T]) where T : Object {
    //        <#code#>
    //    }
    //
    //    func removeObject<T>(_ object: T) where T : Object {
    //        <#code#>
    //    }
    //
    //    func removeAllObjectsOfType<T>(_ type: T.Type) where T : Object {
    //        <#code#>
    //    }
    //
    //    func removeAll() {
    //        <#code#>
    //    }
}
