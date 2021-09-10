//
//  UIModel.swift
//  CV_Builder_App
//
//  Created by Mangesh on 06/09/21.
//

import Foundation

enum FieldNames: String {
    case name = "name"
    case surname = "surname"
    case DateOfBirth = "dateOfBirth"
    case userDescription = "userDescription"
    case fromDate = "from"
    case toDate = "toDate"
    case email = "emailAddress"
    case telephone = "telephone"
    case companyName = "companyName"
    case jobDescription = "jobDescription"
    case institution = "instituteName"
    case educationDescription = "descriptionDetails"
    case designation = "designation"
    case degree = "degreeName"
}

enum FieldType {
    case normalTextField
    case dropDownTextField
}

final class FieldDetails {
    
    var fieldDisplayName: String
    var fieldType: FieldType
    var fieldName: FieldNames
    var fieldValue: String?
    var isDropdownExpanded = false
    var isFieldMandatory = false
    
    init(displayName: String, fieldTypeNme: FieldType, fieldAttributeName: FieldNames, value: String?, isDropDownExpanded: Bool = false, isMandatoryField:Bool = false) {
        fieldDisplayName = displayName
        fieldType = fieldTypeNme
        fieldName = fieldAttributeName
        fieldValue = value
        isDropdownExpanded = isDropDownExpanded
        isFieldMandatory = isMandatoryField
    }
}
