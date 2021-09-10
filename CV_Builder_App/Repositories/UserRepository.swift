//
//  UserRepository.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//
import Foundation
import CoreData

protocol UserRepositoryProtocol {
    func createNewUserCV(fields:[FieldDetails]) -> User
    func getUserDetails(completion:@escaping (([User])->()))
    func updateExistingUserCV(fields:[FieldDetails], currentUser:User)
}

final class UserRepository: UserRepositoryProtocol {
    //MARK:- Properties
    var manageObjectContext: NSManagedObjectContext
    
    //MARK:- Initializers
    init(context: NSManagedObjectContext) {
        manageObjectContext = context
    }
    
    //MARK:- Data methods
    func createNewUserCV(fields: [FieldDetails]) -> User {
        let newUser = User(context: manageObjectContext)
        _ = fields.map { fieldDetails in
            if let value = fieldDetails.fieldValue {
                newUser.setValue(value, forKey: fieldDetails.fieldName.rawValue)
            }
        }
        return newUser
    }
    
    func getUserDetails(completion:@escaping (([User])->())) {
        User.fetchUsers(context: manageObjectContext) { result in
            switch result {
            case .success(let users):
                completion(users)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func updateExistingUserCV(fields:[FieldDetails], currentUser:User) {
        _ = fields.map { fieldDetails in
            if let value = fieldDetails.fieldValue {
                currentUser.setValue(value, forKey: fieldDetails.fieldName.rawValue)
            }
        }
    }
}
