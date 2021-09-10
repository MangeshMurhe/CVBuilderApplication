//
//  CoreDataManager.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import CoreData

final class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "CV_Builder_App")
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
    
    private init() {}
    
    func saveContext () {
        let context = persistentContainer.viewContext
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
