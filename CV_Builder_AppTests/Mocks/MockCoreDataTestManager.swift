//
//  MockCoreDataTestManager.swift
//  CV_Builder_App
//
//  Created by Mangesh on 09/09/21.
//
import CoreData

class MockCoreDataTestManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CV_Builder_App")
        let description = container.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
