//
//  EducationDetailsViewModelTest.swift
//  CV_Builder_AppTests
//
//  Created by Mangesh on 09/09/21.
//
import XCTest
@testable import CV_Builder_App

class EducationDetailsViewModelTest: XCTestCase {
    private var educationDetailsViewModel: EducationDetailViewModel!
    private var mockCoreDataManager: MockCoreDataTestManager!

    override func setUpWithError() throws {
        mockCoreDataManager = MockCoreDataTestManager()
        let education = createEducationModel(instituteName: "MIT, AOE", degree: "Bachelor of Engineering", from: "04/07/2011", to: "16/06/2014", description: "First class")
        educationDetailsViewModel = EducationDetailViewModel(educationDetails: education)
    }

    override func tearDownWithError() throws {
        mockCoreDataManager = nil
    }
    
    func testGetInstituteName() {
        XCTAssertNotNil(educationDetailsViewModel.getInstituteName())
        XCTAssertEqual(educationDetailsViewModel.getInstituteName(), "MIT, AOE")
        XCTAssertFalse(educationDetailsViewModel.getInstituteName() == "MIT AOE")
    }
    
    func testGetDegree() {
        XCTAssertTrue(educationDetailsViewModel.getDegree() == "Bachelor of Engineering")
        XCTAssertFalse(educationDetailsViewModel.getDegree() == "BE")
    }
    
    func testGetTenure() {
        XCTAssertEqual(educationDetailsViewModel.getTenure(), "Jul 2011 to Jun 2014")
    }
    
    func testGetDescription() {
        XCTAssertNotNil(educationDetailsViewModel.getDescription())
    }
    
    private func createEducationModel(instituteName: String?, degree: String?, from: String?, to: String?, description:String?) -> Education {
        let managedContext = mockCoreDataManager.managedObjectContext
        let newEducation = Education(context: managedContext)
        newEducation.instituteName = instituteName
        newEducation.degreeName = degree
        newEducation.from = from
        newEducation.toDate = to
        newEducation.descriptionDetails = description
       return newEducation
    }
}
