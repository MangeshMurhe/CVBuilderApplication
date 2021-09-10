//
//  User+CoreDataClass.swift
//  CV_Builder_App
//
//  Created by Mangesh on 09/09/21.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    class func fetchUsers(context: NSManagedObjectContext, completion:@escaping((Result<[User], DataFetchError>)->())) {
        context.perform {
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            do {
                let userCvs = try fetchRequest.execute()
                completion(.success(userCvs))
            } catch let error {
                completion(.failure(DataFetchError.fetchError(error)))
            }
        }
        
    }
}
