//
//  EducationRepository.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import CoreData

protocol EducationRepositoryProtocol {
    func createNewEducationDetail(fields:[FieldDetails]) -> Education
    func updateCurrentEducationDetails(fields:[FieldDetails], education: Education)
}

final class EducationRepository: EducationRepositoryProtocol {
    //MARK:- Properties
    var manageObjectContext: NSManagedObjectContext
    
    //MARK:- Initializers
    init(context: NSManagedObjectContext) {
        manageObjectContext = context
    }
    
    //MARK:- Data methods
    func updateCurrentEducationDetails(fields: [FieldDetails], education: Education) {
        _ = fields.map { fieldDetails in
            if let value = fieldDetails.fieldValue {
                education.setValue(value, forKey: fieldDetails.fieldName.rawValue)
            }
        }
    }
    
    func createNewEducationDetail(fields: [FieldDetails]) -> Education {
        let newEducationDetail = Education(context: manageObjectContext)
        _ = fields.map { fieldDetails in
            if let value = fieldDetails.fieldValue {
                newEducationDetail.setValue(value, forKey: fieldDetails.fieldName.rawValue)
            }
        }
        return newEducationDetail
    }
}
