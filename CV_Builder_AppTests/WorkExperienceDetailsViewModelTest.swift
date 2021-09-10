//
//  TestWorkExperienceDetailsViewModel.swift
//  CV_Builder_AppTests
//
//  Created by Mangesh on 09/09/21.
//
import XCTest
@testable import CV_Builder_App

class WorkExperienceDetailsViewModelTest: XCTestCase {
    private var workExperienceDetailsViewModel: WorkExperienceDetailsViewModel!
    private var mockCoreDataManager: MockCoreDataTestManager!
    
    override func setUpWithError() throws {
        mockCoreDataManager = MockCoreDataTestManager()
        let firstExperience = createWorkExperienceModel(companyName: "Ansh Systems", designation: "Software developer", from: "04/07/2018", to: "16/08/2020")
        workExperienceDetailsViewModel = WorkExperienceDetailsViewModel(workExperienceDetails: firstExperience)
    }
    
    override func tearDownWithError() throws {
        mockCoreDataManager = nil
    }
    
    func testGetCompanyName() {
        XCTAssertNotNil(workExperienceDetailsViewModel.getCompanyName())
        XCTAssertEqual(workExperienceDetailsViewModel.getCompanyName(), "Ansh Systems")
    }
    
    func testGetDesignation() {
        XCTAssertNotNil(workExperienceDetailsViewModel.getCompanyName())
        XCTAssertEqual(workExperienceDetailsViewModel.getDesignation(), "Software developer")
        XCTAssertFalse(workExperienceDetailsViewModel.getDesignation() == "sr. Software developer")
    }
    
    func testGetWorkTenure() {
        XCTAssertNotNil(workExperienceDetailsViewModel.getWorkTenure())
        XCTAssertTrue(workExperienceDetailsViewModel.getWorkTenure() == "Jul 2018 to Aug 2020")
    }
    
    func testGetDescriptionDetails() {
        XCTAssertNil(workExperienceDetailsViewModel.getDescriptionDetails())
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
