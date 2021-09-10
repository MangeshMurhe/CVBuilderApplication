//
//  UserDetailsViewModelTest.swift
//  CV_Builder_AppTests
//
//  Created by Mangesh on 09/09/21.
//
import XCTest
@testable import CV_Builder_App

class UserDetailsViewModelTest: XCTestCase {
    private var userDetailsViewModel: UserDetailsViewModel!
    
    override func setUpWithError() throws {
        let mockCoreDataManager = MockCoreDataTestManager()
        let userRepository = UserRepository(context: mockCoreDataManager.managedObjectContext)
        let mockGetUserDetailsFieldUseCase = MockUserDetailsFieldUseCase(repository: userRepository)
        userDetailsViewModel = UserDetailsViewModel(userFieldsCase: mockGetUserDetailsFieldUseCase, currentUserCv: nil)
    }

    override func tearDownWithError() throws {
        userDetailsViewModel = nil
    }
    
    func testCreateNewUser() {
        userDetailsViewModel.createNewUser()
        XCTAssertNotNil(userDetailsViewModel.getUserCVDetails())
    }
    
    func testGetUserFullName(){
        userDetailsViewModel.createNewUser()
        XCTAssertEqual(userDetailsViewModel.getUserFullName(), "Mangesh Murhe")
        XCTAssertNotEqual(userDetailsViewModel.getUserFullName(), "Mangesh")
    }
    
    func testGetEmailDisplayName() {
        userDetailsViewModel.createNewUser()
        XCTAssertEqual(userDetailsViewModel.getEmailDisplayName(), "Email: mangesh78@gmail.com")
    }
    
    func testGetDateOfBirth() {
        userDetailsViewModel.createNewUser()
        XCTAssertEqual(userDetailsViewModel.getDateOfBirth(), "DOB: 31/07/1992")
    }
}
