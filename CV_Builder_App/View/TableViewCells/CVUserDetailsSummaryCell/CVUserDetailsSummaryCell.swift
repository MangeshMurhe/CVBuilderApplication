//
//  CVUserDetailsSummaryCell.swift
//  CV_Builder_App
//
//  Created by Mangesh on 08/09/21.
//

import UIKit

class CVUserDetailsSummaryCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet private weak var  profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telephoneNumberLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    
    //MARK:- Setup methods
    func configureCell(viewModel: UserDetailsViewModel) {
        if let imageData = viewModel.getProfileImageData() {
            profileImageView.image = UIImage.init(data: imageData, scale: 1)
        } else {
            profileImageView.image = UIImage(named: "profilePlaceHolder")
        }
        if let fullName = viewModel.getUserFullName() {
            nameLabel.text = fullName
        }
        if let email = viewModel.getEmailDisplayName() {
            emailLabel.text = email
        }
        if let telephone = viewModel.getPhoneNumber() {
            telephoneNumberLabel.text = telephone
        }
        if let dateOfBirth = viewModel.getDateOfBirth() {
            dateOfBirthLabel.text = dateOfBirth
        }
        if let userDescription = viewModel.getUserDescription() {
            userDescriptionLabel.text = userDescription
        }
    }
}
