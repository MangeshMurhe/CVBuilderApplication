//
//  AddNewEducationDetailViewModel.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import Foundation

final class AddNewEducationDetailViewModel {
    private var educationDetail: Education?
    private var getEducationDetailsFieldUseCase: EducationDetailsFieldUseCaseProtocol
    private var educationDetailFields: [FieldDetails] {
        return getEducationDetailsFieldUseCase.getEducationDetailsFields()
    }
    
    //MARK:- Initializers
    init(useCase: EducationDetailsFieldUseCaseProtocol, educationModel: Education?) {
        getEducationDetailsFieldUseCase = useCase
        if let education = educationModel {
            educationDetail = education
            populateFieldModelWithExistingData()
        }
    }
    
    private func createNewEducationDetailModel() {
        educationDetail = getEducationDetailsFieldUseCase.createNewEducationModel()
    }
    
    private func populateFieldModelWithExistingData() {
        _ = educationDetailFields.map({ fieldDataModel  in
            fieldDataModel.fieldValue = educationDetail?.value(forKey: fieldDataModel.fieldName.rawValue) as? String
        })
    }
    
    func isValidDetails() -> Bool {
        let result = educationDetailFields.map { fieldDataModel -> Bool in
            if fieldDataModel.isFieldMandatory && fieldDataModel.fieldValue == nil  {
                return false
            } else {
                return true
            }
        }
        return result.filter{ $0 == false}.count > 0 ? false : true
    }
    
    func getEducationDetailsFields()-> [FieldDetails] {
        return educationDetailFields
    }
    
    func saveEducationDetail() {
        if let currentEducationDetail = educationDetail {
            getEducationDetailsFieldUseCase.updateExistingEducationDetails(education: currentEducationDetail)
        } else {
            createNewEducationDetailModel()
        }
        
    }
    
    func getNewlyAddedEducation()-> Education? {
        return educationDetail
    }
}
