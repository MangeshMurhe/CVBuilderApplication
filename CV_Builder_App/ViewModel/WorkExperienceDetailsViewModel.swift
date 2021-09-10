//
//  WorkExperienceDetailsViewModel.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import Foundation

final class WorkExperienceDetailsViewModel {
    private var workExperience: WorkExperience
    
    init(workExperienceDetails: WorkExperience) {
        workExperience = workExperienceDetails
    }
    
    func getCompanyName()-> String? {
        return workExperience.companyName
    }
    
    func getDesignation()-> String? {
        return workExperience.designation
    }
    
    func getWorkTenure()-> String? {
        if let fromDate = workExperience.from, let toDate = workExperience.toDate,  let fromDateInMonthFormat = fromDate.getDateFromString()?.getDateStringInMonthNameFormat(), let toDateInMonthFormat = toDate.getDateFromString()?.getDateStringInMonthNameFormat() {
           
        return "\(fromDateInMonthFormat) to \(toDateInMonthFormat)"
        }
        return nil
    }
    
    func getDescriptionDetails() -> String? {
        return workExperience.jobDescription
    }
}
