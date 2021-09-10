//
//  WorkExperienceRepository.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import Foundation
import CoreData

protocol WorkExperienceRepositoryProtocol {
    func createNewWorkExperience(fields:[FieldDetails])-> WorkExperience
    func updateCurrentWorkExperience(fields:[FieldDetails], workExperience: WorkExperience)
}

final class WorkExperienceRepository: WorkExperienceRepositoryProtocol {
    //MARK:- Properties
    var manageObjectContext: NSManagedObjectContext
    
    //MARK:- Initializers
    init(context: NSManagedObjectContext) {
        manageObjectContext = context
    }
    
    //MARK:- Data methods
    func updateCurrentWorkExperience(fields: [FieldDetails], workExperience: WorkExperience) {
        _ = fields.map { fieldDetails in
            if let value = fieldDetails.fieldValue {
                workExperience.setValue(value, forKey: fieldDetails.fieldName.rawValue)
            }
        }
    }
    
    func createNewWorkExperience(fields: [FieldDetails]) -> WorkExperience {
        let newWorkExperience = WorkExperience(context: manageObjectContext)
        _ = fields.map { fieldDetails in
            if let value = fieldDetails.fieldValue {
                newWorkExperience.setValue(value, forKey: fieldDetails.fieldName.rawValue)
            }
        }
        return newWorkExperience
    }
}
