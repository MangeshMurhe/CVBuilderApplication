//
//  WorkExperincesListViewModel.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import Foundation

class WorkExperincesListViewModel {
    private var userCv: User
    
    init(user: User) {
        userCv = user
    }
    
    private var workExperiences: [WorkExperience]? {
        return userCv.workExperiences?.allObjects as? [WorkExperience]
    }
    
    var totalWorkExperiences: Int {
        return userCv.workExperiences?.count ?? 0
    }
    
    func addNewWorkExperience(newWorkExperience: WorkExperience?) {
        if let workExperience = newWorkExperience {
         userCv.addToWorkExperiences(workExperience)
        }
    }
    
    func getWorkExperienceAt(index:Int) -> WorkExperience? {
        if let experience = workExperiences?[index] {
            return experience
        }
        return nil
    }
    
    func getUserDetails()-> User {
        return userCv
    }
}
