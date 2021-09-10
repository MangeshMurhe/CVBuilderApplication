//
//  GetWorkExperienceFiledsUseCase.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//
import Foundation

protocol WorkExperienceFieldUseCaseProtocol {
    func getNewWorkDetailsField()-> [FieldDetails]
    func updateExistingWorkExperience(workExperience: WorkExperience)
    func createNewWorkExperience() -> WorkExperience
}

class GetWorkExperienceFieldsUseCase: WorkExperienceFieldUseCaseProtocol {
    //MARK:- Properties
    var workExperienceRepository: WorkExperienceRepositoryProtocol
    private let fieldsArray = [FieldDetails(displayName: "Company", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.companyName, value: nil, isMandatoryField: true), FieldDetails(displayName: "Designation", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.designation, value: nil, isMandatoryField: true), FieldDetails(displayName: "From", fieldTypeNme: FieldType.dropDownTextField, fieldAttributeName: FieldNames.fromDate, value: nil, isMandatoryField: true), FieldDetails(displayName: "To", fieldTypeNme: FieldType.dropDownTextField, fieldAttributeName: FieldNames.toDate, value: nil, isMandatoryField: true), FieldDetails(displayName: "Job Description", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.jobDescription, value: nil)]
    
    init(repository: WorkExperienceRepositoryProtocol) {
        workExperienceRepository = repository
    }
    
    func getNewWorkDetailsField()-> [FieldDetails] {
        return fieldsArray
    }
    
    func updateExistingWorkExperience(workExperience: WorkExperience) {
        workExperienceRepository.updateCurrentWorkExperience(fields: fieldsArray, workExperience: workExperience)
    }
    
    func createNewWorkExperience() -> WorkExperience {
        return workExperienceRepository.createNewWorkExperience(fields: fieldsArray)
    }
}

class MockGetWorkExperienceFieldsUseCase: GetWorkExperienceFieldsUseCase {
    private let fieldsArray = [FieldDetails(displayName: "Company", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.companyName, value: "LTI", isMandatoryField: true), FieldDetails(displayName: "Designation", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.designation, value: "sr. Software Developer", isMandatoryField: true), FieldDetails(displayName: "From", fieldTypeNme: FieldType.dropDownTextField, fieldAttributeName: FieldNames.fromDate, value: "18/4/2016", isMandatoryField: true), FieldDetails(displayName: "To", fieldTypeNme: FieldType.dropDownTextField, fieldAttributeName: FieldNames.toDate, value: "25/7/2020", isMandatoryField: true)]
    
    override func getNewWorkDetailsField() -> [FieldDetails] {
        return fieldsArray
    }
    
     override func updateExistingWorkExperience(workExperience: WorkExperience) {
        workExperienceRepository.updateCurrentWorkExperience(fields: fieldsArray, workExperience: workExperience)
    }
    
    override func createNewWorkExperience() -> WorkExperience {
        return workExperienceRepository.createNewWorkExperience(fields: fieldsArray)
    }
}
