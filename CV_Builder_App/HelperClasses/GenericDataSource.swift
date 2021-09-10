//
//  GenericDataSource.swift
//  CV_Builder_App
//
//  Created by Mangesh on 06/09/21.
//

import Foundation
import UIKit

class GenericDataSource: NSObject {
    
    //MARK:- Properties
    var array = [FieldDetails]()
    let fieldCellIdentifier = "fieldCell"
    let  datePickerCellIdentifier = "dateCell"
    var footerButtonCallback:(()->Void)?
    
    //MARK:- Setup methods
    func registerCellWith(tableView: UITableView) {
        tableView.register(UINib(nibName: "InputFieldTableCell", bundle: nil), forCellReuseIdentifier: fieldCellIdentifier)
        tableView.register(UINib(nibName: "DatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: datePickerCellIdentifier)
        tableView.estimatedRowHeight = 80
        tableView.tableFooterView = UIView()
    }
    
    @objc private func nextButtonClicked() {
        if let callback = footerButtonCallback {
            callback()
        }
    }
}

//MARK:- Table view data source methods
extension GenericDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let field = array[section]
        if field.fieldType == FieldType.dropDownTextField && field.isDropdownExpanded == true {
            return 2
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: fieldCellIdentifier, for: indexPath) as? InputFieldTableCell
            cell?.setUpData(currentField: array[indexPath.section], section: indexPath.section)
            cell?.reloadCompletion = { section in
                let field = self.array[section]
                if field.isDropdownExpanded == true {
                    field.isDropdownExpanded = false
                    let sections = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(sections, with: .none)
                } else {
                    field.isDropdownExpanded = true
                    let sections = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(sections, with: .none)
                }
            }
            return cell!
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: datePickerCellIdentifier, for: indexPath) as? DatePickerTableViewCell
            cell?.setUpData(field: array[indexPath.section], section: indexPath.section)
            cell?.reloadSectionCallback = { section in
                let field = self.array[section]
                if field.isDropdownExpanded == true {
                    field.isDropdownExpanded = false
                    let sections = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(sections, with: .none)
                } else {
                    field.isDropdownExpanded = true
                    let sections = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(sections, with: .none)
                }
            }
            return cell!
        }
    }
}

//MARK:- Table view delegate methods
extension GenericDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 44
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 40))
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: headerView.frame.width, height: headerView.frame.height - 5))
        let displayName = array[section].fieldDisplayName.localized
        if array[section].isFieldMandatory {
            titleLabel.attributedText = (displayName + "*").returnMandatoryFieldName()
        } else {
            titleLabel.text = displayName
        }
        headerView.addSubview(titleLabel)
        headerView.bringSubviewToFront(titleLabel)
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 16))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
}
