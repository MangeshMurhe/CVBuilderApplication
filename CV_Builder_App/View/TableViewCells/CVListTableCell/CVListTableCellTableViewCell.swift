//
//  CVListTableCellTableViewCell.swift
//  CV_Builder_App
//
//  Created by Mangesh on 06/09/21.
//

import UIKit

final class CVListTableViewCell: UITableViewCell {
//MARK:- Outlets
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    
//MARK:- Setup methods
    func setUpUserDetails(viewModel: UserDetailsViewModel) {
        if let profileImageData = viewModel.getProfileImageData() {
            profileImageView.image = UIImage(data: profileImageData)
        }
        
        if let name = viewModel.getUserFullName() {
            userNameLabel.text = name
        }
    }
    
}
