//
//  AddNewWorkExperienceVM.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import Foundation

final class AddNewWorkExperienceViewModel {
    //MARK:- Properties
    private var workExperience: WorkExperience?
    private var getWorkExperienceFieldsUseCase: WorkExperienceFieldUseCaseProtocol
    private var workExperienceDetailFields: [FieldDetails] {
        return getWorkExperienceFieldsUseCase.getNewWorkDetailsField()
    }
    
    //MARK:- Initializers
    init(useCase: WorkExperienceFieldUseCaseProtocol, workExperienceModel: WorkExperience?) {
        getWorkExperienceFieldsUseCase = useCase
        if let experience = workExperienceModel {
            workExperience = experience
            populateFieldModelWithExistingData()
        }
    }
    
    func createNewWorkExperienceModel() {
        workExperience = getWorkExperienceFieldsUseCase.createNewWorkExperience()
    }
    
    private func populateFieldModelWithExistingData() {
         _ = workExperienceDetailFields.map({ fieldDataModel  in
             fieldDataModel.fieldValue = workExperience?.value(forKey: fieldDataModel.fieldName.rawValue) as? String
         })
     }
    
    func getAddWorkExperienceFields()-> [FieldDetails] {
        return getWorkExperienceFieldsUseCase.getNewWorkDetailsField()
    }
    
    func saveWorkExperience() {
        if let currentWorkExperience = workExperience {
            getWorkExperienceFieldsUseCase.updateExistingWorkExperience(workExperience: currentWorkExperience)
        } else {
            createNewWorkExperienceModel()
        }
        
    }
    
    func getWorkExperience()-> WorkExperience? {
        return workExperience
    }
    
    func isValidDetails() -> Bool {
       let result = workExperienceDetailFields.map { fieldDataModel -> Bool in
            if fieldDataModel.isFieldMandatory && fieldDataModel.fieldValue == nil  {
                return false
            } else {
                return true
            }
        }
        return result.filter{ $0 == false}.count > 0 ? false : true
    }
}
