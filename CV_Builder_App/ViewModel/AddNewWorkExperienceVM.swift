//
//  AddNewWorkExperienceVM.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import Foundation

final class AddNewWorkExperienceViewModel {
    var workExperienceRepository: WorkExperienceRepositoryProtocol
    var workExperience: WorkExperience?
    let addWorkExperienceFields = [FieldDetails(displayName: "Company", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.companyName, value: nil), FieldDetails(displayName: "From", fieldTypeNme: FieldType.dropDownTextField, fieldAttributeName: FieldNames.fromDate, value: nil), FieldDetails(displayName: "To", fieldTypeNme: FieldType.dropDownTextField, fieldAttributeName: FieldNames.toDate, value: nil), FieldDetails(displayName: "Job Description", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.jobDescription, value: nil)]
    
    init(repository: WorkExperienceRepositoryProtocol) {
        workExperienceRepository = repository
    }
    
    func getAddWorkExperienceFields()-> [FieldDetails] {
        return addWorkExperienceFields
    }
    
    func saveWorkExperience() {
        workExperience = workExperienceRepository.saveWorkExperience(fields: addWorkExperienceFields)
    }

}
