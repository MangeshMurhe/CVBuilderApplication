//
//  datePickerTableViewCell.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    //MARK:- Properties
    private var fieldDetails: FieldDetails?
    private var cellSection: Int?
    var reloadSectionCallback:((Int)->Void)?
    
    //MARK:- Setup methods
    func setUpData(field: FieldDetails, section: Int) {
        fieldDetails = field
        cellSection = section
        if let value = field.fieldValue, let date = value.getDateFromString() {
            datePicker.date = date
        }
        datePicker.maximumDate = Date()
    }
    
    @IBAction private func doneButtonClicked() {
        if let field = fieldDetails {
            field.fieldValue = datePicker.date.getStringFromDate()
            if let callback = reloadSectionCallback, let section = cellSection {
                callback(section)
            }
        }
    }
}
