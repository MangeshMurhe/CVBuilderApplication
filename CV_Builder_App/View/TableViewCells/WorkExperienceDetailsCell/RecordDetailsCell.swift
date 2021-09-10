//
//  WorkExperienceDetailsCell.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import UIKit

final class RecordDetailsCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet  private weak var companyNameLabel: UILabel!
    @IBOutlet  private weak var designationLabel: UILabel!
    @IBOutlet  private weak var durationLabel: UILabel!
    @IBOutlet private weak var desciptionDetailsLabel: UILabel!
    @IBOutlet private weak var editIconImageView: UIImageView!
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                switch previousTraitCollection?.userInterfaceStyle {
                case .dark:
                    cardView.layer.borderColor = UIColor.black.cgColor
                case .light:
                    cardView.layer.borderColor = UIColor.white.cgColor
                default:
                    cardView.layer.borderColor = UIColor.black.cgColor
                }
            }
        }
    }
    
    //MARK:- Setup methods
    func configure(viewModel: WorkExperienceDetailsViewModel, isShowEditOption: Bool = false) {
        if isShowEditOption {
            editIconImageView.isHidden = false
        } else {
            editIconImageView.isHidden = true
        }
        cardView.showBorder(borderWidth: 0.5)
        
        if let companyName = viewModel.getCompanyName() {
            companyNameLabel.text = companyName
        }
        if let designation = viewModel.getDesignation() {
            designationLabel.text = designation
        }
        if let duration = viewModel.getWorkTenure() {
            durationLabel.text = duration
        }
        if let jobDescription = viewModel.getDescriptionDetails() {
            desciptionDetailsLabel.text = jobDescription
        }
        cardView.showBorder(borderWidth: 0.5)
        cardView.layer.borderColor = self.traitCollection.userInterfaceStyle == .light ? UIColor.black.cgColor : UIColor.white.cgColor
    }
}
