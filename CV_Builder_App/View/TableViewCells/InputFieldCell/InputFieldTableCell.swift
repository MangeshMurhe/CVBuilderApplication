//
//  detailsFieldTableCellTableViewCell.swift
//  CV_Builder_App
//
//  Created by Mangesh on 06/09/21.
//

import UIKit

final class InputFieldTableCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet private weak var detailsTextField: UITextField! {
        didSet {
            detailsTextField.delegate = self
            detailsTextField.borderStyle = .none
            detailsTextField.setLeftPaddingPoints(5)
        }
    }
    
    @IBOutlet private var downArrowImageView: UIImageView!
    
    //MARK:- Properties
    var reloadCompletion: ((Int)->Void)?
    private var fieldDataModel: FieldDetails?
    private var cellSection = 0
    
    //MARK:- Life cycle methods
    override func prepareForReuse() {
        fieldDataModel = nil
        detailsTextField.text = nil
        detailsTextField.cornerRadius = 0
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                switch previousTraitCollection?.userInterfaceStyle {
                case .dark:
                    detailsTextField.layer.borderColor = UIColor.black.cgColor
                case .light:
                    detailsTextField.layer.borderColor = UIColor.white.cgColor
                default:
                    detailsTextField.layer.borderColor = UIColor.black.cgColor
                }
            }
        }
    }
    //MARK:- Setup methods
    func setUpData(currentField: FieldDetails, section: Int) {
        fieldDataModel = currentField
        cellSection = section
        if fieldDataModel?.fieldType == FieldType.dropDownTextField {
            downArrowImageView.isHidden = false
            detailsTextField.cornerRadius = 10
            detailsTextField.doneAccessory = false
        } else {
            downArrowImageView.isHidden = true
            detailsTextField.doneAccessory = true
        }
        if let value = currentField.fieldValue {
            detailsTextField.text = value
        }
        detailsTextField.showBorder(borderWidth: 1.0)
        detailsTextField.layer.borderColor = self.traitCollection.userInterfaceStyle == .light ? UIColor.black.cgColor : UIColor.white.cgColor
    }
}

//MARK:- Textfield delegate methods
extension InputFieldTableCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if fieldDataModel?.fieldType == FieldType.dropDownTextField {
          reloadCompletion?(cellSection)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let value = textField.text ?? ""
        if !value.isEmpty {
            fieldDataModel?.fieldValue = value
        } else {
            fieldDataModel?.fieldValue = nil
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
