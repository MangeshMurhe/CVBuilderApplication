//
//  UserModelTest.swift
//  CV_Builder_AppTests
//
//  Created by Mangesh on 09/09/21.
//
import XCTest
@testable import CV_Builder_App

class UserModelTest: XCTestCase {
    var mockCoreDataManager: MockCoreDataTestManager!
    
    override func setUpWithError() throws {
        mockCoreDataManager = MockCoreDataTestManager()
    }

    override func tearDownWithError() throws {
        mockCoreDataManager = nil
    }

    func testUserModel() throws {
       let firstUser = createUserModel(name: "Mangesh", surName: "Murhe", email: "mangesh123@gmail.com", dateOfBirth: nil)
        
        let secondUser = createUserModel(name: "Mangesh", surName: "Murhe", email: nil, dateOfBirth: nil)
        
        XCTAssertNil(firstUser.dateOfBirth)
        XCTAssertNotEqual(firstUser.name, "Murhe")
        XCTAssertNotNil(firstUser.name, "")
        XCTAssertNotEqual(firstUser, secondUser)
    }

    private func createUserModel(name: String?, surName: String?, email: String?, dateOfBirth: String?) -> User {
        let managedContext = mockCoreDataManager.managedObjectContext
        let newUser = User(context: managedContext)
        newUser.name = name
        newUser.surname = surName
        newUser.emailAddress = email
        newUser.dateOfBirth = dateOfBirth
        return newUser
    }
}
