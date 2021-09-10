//
//  EducationDetailsListViewModel.swift
//  CV_Builder_App
//
//  Created by Mangesh on 08/09/21.
//

import Foundation

final class EducationDetailsListViewModel {
    private var userCv: User
    
    init(user: User) {
        userCv = user
    }
    private var educationDetails: [Education]? {
        return userCv.educationDetails?.allObjects as? [Education]
    }
    
    var totalEducationDetails: Int {
        return userCv.educationDetails?.count ?? 0
    }
    
    func addNewEducation(newEducationDetails: Education?) {
        if let educationDetails = newEducationDetails {
         userCv.addToEducationDetails(educationDetails)
        }
    }
    
    func getCurrentUserCV() -> User {
       return userCv
    }
    
    func getEducationDetailsAt(index:Int) -> Education? {
        if let educationDetail = educationDetails?[index] {
            return educationDetail
        }
        return nil
    }
    
    func saveUserCVDetails() {
        CoreDataManager.sharedInstance.saveContext()
    }
}
