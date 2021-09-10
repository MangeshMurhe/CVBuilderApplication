//
//  EducationModelTest.swift
//  CV_Builder_AppTests
//
//  Created by Mangesh on 09/09/21.
//

import XCTest
@testable import CV_Builder_App

class EducationModelTest: XCTestCase {
    private var mockCoreDataManager: MockCoreDataTestManager!
    
    override func setUpWithError() throws {
        mockCoreDataManager = MockCoreDataTestManager()
    }
    
    override func tearDownWithError() throws {
        mockCoreDataManager = nil
    }
    
    func testEducationModel() {
        let firstEducation = createEducationModel(instituteName: "MIT, AOE", degree: "Bachelor of Engineering", from: "04/07/2011", to: "16/06/2014")
        XCTAssertNotNil(firstEducation)
        XCTAssertNil(firstEducation.descriptionDetails)
        XCTAssertTrue(firstEducation.instituteName == "MIT, AOE")
    }
    
    private func createEducationModel(instituteName: String?, degree: String?, from: String?, to: String?) -> Education {
        let managedContext = mockCoreDataManager.managedObjectContext
        let newEducation = Education(context: managedContext)
        newEducation.instituteName = instituteName
        newEducation.degreeName = degree
        newEducation.from = from
        newEducation.toDate = to
       return newEducation
    }
}
