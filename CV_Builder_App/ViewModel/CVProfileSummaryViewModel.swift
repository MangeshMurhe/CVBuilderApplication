//
//  CVProfileSummaryViewModel.swift
//  CV_Builder_App
//
//  Created by Mangesh on 08/09/21.
//

import Foundation

class CVProfileSummaryViewModel{
    private var userCV: User
    
    var sections: [String] {
        return ["User Details", "Work Experience", "Education"]
    }
    
    private var workExperiences: [WorkExperience]? {
        return userCV.workExperiences?.allObjects as? [WorkExperience]
    }
    
    private var educationDetails: [Education]? {
        return userCV.educationDetails?.allObjects as? [Education]
    }
    
    func getUserCVDetail() -> User {
        return userCV
    }
    
    init(userCVDetails: User) {
        userCV = userCVDetails
    }
    
    func getTotalWorkExperiences() -> Int {
        return workExperiences?.count ?? 0
    }
    
    func getTotalEducationDetails()-> Int {
        return educationDetails?.count ?? 0
    }
    
    func getWorkExperienceAt(index: Int) -> WorkExperience? {
        return workExperiences?[index]
    }
    
    func getEducationAt(index: Int) -> Education? {
        return educationDetails?[index]
    }
    
    func getUserNameToSavePdf()->String? {
        if let name = userCV.name, let surname = userCV.surname {
            return "\(name)_\(surname)_CV"
        }
        return nil
    }
}
