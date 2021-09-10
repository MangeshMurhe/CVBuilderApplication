//
//  AddNewWorkExperienceViewModelTest.swift
//  CV_Builder_AppTests
//
//  Created by Mangesh on 09/09/21.
//
import XCTest
@testable import CV_Builder_App

class AddNewWorkExperienceViewModelTest: XCTestCase {
    private var addWorkExperienceViewModel: AddNewWorkExperienceViewModel!
    
    override func setUpWithError() throws {
        let mockCoreDataManager = MockCoreDataTestManager()
        let workExperienceRepository = WorkExperienceRepository(context: mockCoreDataManager.managedObjectContext)
        let mockGetWorkExperienceFieldsUseCase = MockGetWorkExperienceFieldsUseCase(repository: workExperienceRepository)
        addWorkExperienceViewModel = AddNewWorkExperienceViewModel(useCase: mockGetWorkExperienceFieldsUseCase, workExperienceModel: nil)
    }

    override func tearDownWithError() throws {
        addWorkExperienceViewModel = nil
    }

    func testcreateNewEducationDetailModel() {
        addWorkExperienceViewModel.createNewWorkExperienceModel()
        XCTAssertNotNil(addWorkExperienceViewModel.getWorkExperience())
    }
    
    func testIsValidDetails() {
        XCTAssertTrue(addWorkExperienceViewModel.isValidDetails())
    }
    
    func testGetEducationDetailFields() {
        let fieldsCount = addWorkExperienceViewModel.getAddWorkExperienceFields().count
        XCTAssertTrue(fieldsCount == 4)
        XCTAssertFalse(fieldsCount == 0)
    }
}
