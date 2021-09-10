//
//  GetEducationDetailsFieldsUseCase.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//
import Foundation

protocol EducationDetailsFieldUseCaseProtocol {
    func getEducationDetailsFields()-> [FieldDetails]
    func updateExistingEducationDetails(education: Education)
    func createNewEducationModel() -> Education
}

class GetEducationDetailsFieldUseCase: EducationDetailsFieldUseCaseProtocol {
    
    var educationDetailRepository: EducationRepositoryProtocol
    private let fieldsArray = [FieldDetails(displayName: "Institution", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.institution, value: nil, isMandatoryField: true), FieldDetails(displayName: "Degree", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.degree, value: nil, isMandatoryField: true), FieldDetails(displayName: "From", fieldTypeNme: FieldType.dropDownTextField, fieldAttributeName: FieldNames.fromDate, value: nil, isMandatoryField: true), FieldDetails(displayName: "To", fieldTypeNme: FieldType.dropDownTextField, fieldAttributeName: FieldNames.toDate, value: nil, isMandatoryField: true), FieldDetails(displayName: "Description", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.educationDescription, value: nil)]
    
    init(repository: EducationRepositoryProtocol) {
        educationDetailRepository = repository
    }
    
    func getEducationDetailsFields()-> [FieldDetails] {
        return fieldsArray
    }
    
    func updateExistingEducationDetails(education: Education) {
        educationDetailRepository.updateCurrentEducationDetails(fields: fieldsArray, education: education)
    }
    
    func createNewEducationModel() -> Education {
       return educationDetailRepository.createNewEducationDetail(fields: fieldsArray)
    }
}
