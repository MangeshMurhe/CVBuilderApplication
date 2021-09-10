//
//  MockFetchUsersCVUseCase.swift
//  CV_Builder_App
//
//  Created by Mangesh on 10/09/21.
//
import Foundation
import CoreData

class MockFetchUsersCVUseCase: FetchUsersCVUseCaseProtocol {
    var completionCallback: (()->Void)?
    
    func fetchUsers(completion: @escaping (([User]) -> ())) {
        let mockCoreDataManager = MockCoreDataTestManager()
        let firstUser = createUserModel(name: "Mangesh", surName: "Murhe", email: "mangesh899@gmail.com", dateOfBirth: "29/2/1993", manageObjectContext: mockCoreDataManager.managedObjectContext)
        let secondUser = createUserModel(name: "Ketan", surName: "Chavan", email: "kchavan@gmail.com", dateOfBirth: "14/4/1993", manageObjectContext: mockCoreDataManager.managedObjectContext)
        completion([firstUser, secondUser])
        if let callback = completionCallback {
            callback()
        }
    }
    
    private func createUserModel(name: String?, surName: String?, email: String?, dateOfBirth: String?, manageObjectContext: NSManagedObjectContext) -> User {
        let newUser = User(context: manageObjectContext)
        newUser.name = name
        newUser.surname = surName
        newUser.emailAddress = email
        newUser.dateOfBirth = dateOfBirth
        return newUser
    }
}
