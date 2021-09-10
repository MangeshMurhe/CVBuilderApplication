//
//  EducationDetailsCell.swift
//  CV_Builder_App
//
//  Created by Mangesh on 08/09/21.
//

import UIKit

final class EducationDetailsCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var instituteNameLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
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
    func configureCell(viewModel: EducationDetailViewModel, isShowEditOption: Bool = false) {
        if isShowEditOption {
            editIconImageView.isHidden = false
        } else {
            editIconImageView.isHidden = true
        }
        cardView.showBorder(borderWidth: 0.5)
        if let instituteName = viewModel.getInstituteName() {
            instituteNameLabel.text = instituteName
        }
        if let degreeName = viewModel.getDegree() {
            degreeLabel.text = degreeName
        }
        if let duration = viewModel.getTenure() {
            durationLabel.text = duration
        }
        if let descriptionDetails = viewModel.getDescription() {
            descriptionLabel.text = descriptionDetails
        }
        cardView.showBorder(borderWidth: 0.5)
        cardView.layer.borderColor = self.traitCollection.userInterfaceStyle == .light ? UIColor.black.cgColor : UIColor.white.cgColor
    }
}
