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
    @IBOutlet private weak var cardView: UIView!
    
    //MARK:- Life cycle methods
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
    func setUpUserDetails(viewModel: UserDetailsViewModel) {
        if let profileImageData = viewModel.getProfileImageData() {
            profileImageView.image = UIImage(data: profileImageData)
        } else {
            profileImageView.image = UIImage(named: "profilePlaceHolder")
        }
        
        if let name = viewModel.getUserFullName() {
            userNameLabel.text = name
        }
        cardView.showBorder(borderWidth: 0.5)
        cardView.layer.borderColor = self.traitCollection.userInterfaceStyle == .light ? UIColor.black.cgColor : UIColor.white.cgColor
    }
}
