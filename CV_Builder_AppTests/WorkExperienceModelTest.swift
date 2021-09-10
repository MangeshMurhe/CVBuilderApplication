//
//  WorkExperienceModelTest.swift
//  CV_Builder_AppTests
//
//  Created by Mangesh on 09/09/21.
//
import XCTest
@testable import CV_Builder_App

class WorkExperienceModelTest: XCTestCase {
    var mockCoreDataManager: MockCoreDataTestManager!
    
    override func setUpWithError() throws {
        mockCoreDataManager = MockCoreDataTestManager()
    }

    override func tearDownWithError() throws {
        mockCoreDataManager = nil
    }

    func testWorkExperienceModel() {
        let firstExperience = createWorkExperienceModel(companyName: "Ansh Systems", designation: "Software developer", from: "Jul 2018", to: "Jun 2019")
        let secondExperience = createWorkExperienceModel(companyName: "Ansh Systems", designation: "sr. Software developer", from: "Jul 2018", to: "Jun 2019")
        let thirdExperience = createWorkExperienceModel(companyName: "Ansh Systems", designation: "Software developer", from: "Jul 2018", to: "Jun 2019")
        XCTAssertNotNil(firstExperience)
        XCTAssertTrue(firstExperience == thirdExperience)
        XCTAssertFalse(firstExperience == secondExperience)
    }
    
    private func createWorkExperienceModel(companyName: String?, designation: String?, from: String?, to: String?) -> WorkExperience {
        let managedContext = mockCoreDataManager.managedObjectContext
        let newWorkExperience = WorkExperience(context: managedContext)
        newWorkExperience.companyName = companyName
        newWorkExperience.designation = designation
        newWorkExperience.from = from
        newWorkExperience.toDate = to
       return newWorkExperience
    }
}
