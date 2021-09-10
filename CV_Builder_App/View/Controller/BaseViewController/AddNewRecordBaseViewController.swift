//
//  AddNewRecordBaseViewController.swift
//  CV_Builder_App
//
//  Created by Mangesh on 08/09/21.
//

import UIKit

class AddNewRecordBaseViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet private weak var addNewRecordFieldsTableView: UITableView!
    @IBOutlet private weak var tableViewBottomConstraint: NSLayoutConstraint!

    let genericDataSource = GenericDataSource()
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        setUpTapGuestureForTableView()
        setupKeyBoardNotificationObservers()
    }
    
    //MARK:- Action methods
    @IBAction func closeForm() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: false, completion: nil)
    }
    
    @objc func hideKeyboard() {
        addNewRecordFieldsTableView.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableViewBottomConstraint.constant = keyboardSize.height - 60
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
            tableViewBottomConstraint.constant = 0
    }
    
    //MARK:- Setup methods
    private func setUpTapGuestureForTableView() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(hideKeyboard))
            tapGesture.cancelsTouchesInView = true
        addNewRecordFieldsTableView.addGestureRecognizer(tapGesture)
    }
    
    private func setupKeyBoardNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupDataSource() {
        genericDataSource.registerCellWith(tableView: addNewRecordFieldsTableView)
        addNewRecordFieldsTableView.dataSource = genericDataSource
        addNewRecordFieldsTableView.delegate = genericDataSource
    }
}
