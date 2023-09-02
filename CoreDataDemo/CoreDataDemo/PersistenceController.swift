//
//  PersistenceController.swift
//  CoreDataDemo
//
//  Created by Naela Fauzul Muna on 20/08/23.
//

import Foundation
import CoreData
 
struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
 
    init() {
        container = NSPersistentContainer(name: "Products")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
    }
}
