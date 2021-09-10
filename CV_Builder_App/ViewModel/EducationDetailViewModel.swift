//
//  EducationDetailViewModel.swift
//  CV_Builder_App
//
//  Created by Mangesh on 08/09/21.
//

import Foundation

final class EducationDetailViewModel {
    private var education: Education
    
    init(educationDetails: Education) {
        education = educationDetails
    }
    
    func getInstituteName() -> String? {
        return education.instituteName
    }
    
    func getDegree()-> String? {
        return education.degreeName
    }
    
    func getTenure()-> String? {
        if let fromDate = education.from, let toDate = education.toDate,  let fromDateInMonthFormat = fromDate.getDateFromString()?.getDateStringInMonthNameFormat(), let toDateInMonthFormat = toDate.getDateFromString()?.getDateStringInMonthNameFormat() {
           
        return "\(fromDateInMonthFormat) to \(toDateInMonthFormat)"
        }
        return nil
    }
    
    func getDescription() -> String? {
        return education.descriptionDetails
    }
}
