//
//  CoreDataStack.swift
//  drunk_presidents_frontend
//
//  Created by Tony Cioara on 2/9/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//


import Foundation
import CoreData

public final class CoreDataStack {
    static let instance = CoreDataStack()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(
            name: "storedQuote"
        )
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let viewContext = persistentContainer.viewContext
        return viewContext
    }()
    
    lazy var privateContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    func saveTo(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

