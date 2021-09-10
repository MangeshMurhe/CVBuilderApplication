//
//  UserCVListViewModelTest.swift
//  CV_Builder_AppTests
//
//  Created by Mangesh on 09/09/21.
//
import XCTest
@testable import CV_Builder_App

class UserCVListViewModelTest: XCTestCase {
    private var usersCVListViewModel: UserCVListViewModel!
    private var mockFetchUsersUseCase:MockFetchUsersCVUseCase!
    
    override func setUpWithError() throws {
       mockFetchUsersUseCase = MockFetchUsersCVUseCase()
        usersCVListViewModel = UserCVListViewModel(usecase: mockFetchUsersUseCase)
    }

    override func tearDownWithError() throws {
      usersCVListViewModel = nil
        mockFetchUsersUseCase = nil
    }

    func testFetchUsers() throws {
        let expectation = XCTestExpectation(description: "fetch user cvs")
        mockFetchUsersUseCase.completionCallback = {[weak self] in
            XCTAssertEqual(self?.usersCVListViewModel.totalUserCVs, 2)
            expectation.fulfill()
        }
        usersCVListViewModel.fetchUsersCV()
        wait(for: [expectation], timeout: 5)
    }
}
