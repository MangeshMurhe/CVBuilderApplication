//
//  WorkExperienceDetailsCell.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import UIKit

final class RecordDetailsCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet  weak var companyOrInstituteNameLabel: UILabel!
    @IBOutlet  weak var designationOrDegreeLabel: UILabel!
    @IBOutlet  weak var durationLabel: UILabel!
    
    func configure(viewModel: BaseDetailModel) {
        if let workExperienceViewModel = viewModel as? WorkExperienceDetailsViewModel {
            companyOrInstituteNameLabel.text = workExperienceViewModel.getCompanyName()
            designationOrDegreeLabel.text = workExperienceViewModel.getDesignation()
        durationLabel.text = workExperienceViewModel.getWorkTenure()
        } else if let educationDetailViewModel = viewModel as? EducationDetailViewModel {
            
        }
    }
}
