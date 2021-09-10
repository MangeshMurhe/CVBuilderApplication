//
//  BaseListController.swift
//  CV_Builder_App
//
//  Created by Mangesh on 08/09/21.
//

import UIKit

class BaseListViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var recordsListTableView: UITableView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    private lazy var cancelButtonTitle = "Cancel"
    private lazy var continueButtonTitle = "Continue"
    private lazy var addButtonTitle = "Add"
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTopButton()
    }
    
    //MARK:- Action methods
    @objc func addButtonClicked() {}
    
    //MARK:- Setup methods
    func registerTableCellNib(nibName:String, cellIdentifier: String) {
        recordsListTableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        recordsListTableView.tableFooterView = UIView()
    }
    
    private func setUpTopButton() {
        let add = UIBarButtonItem(title: addButtonTitle.localized, style: .plain, target: self, action: #selector(addButtonClicked))
        add.tintColor = UIColor.label
        navigationItem.rightBarButtonItems = [add]
    }
    
    func setUpPlaceHolderText(recordsCount: Int) {
        if recordsCount == 0 {
            placeholderLabel.isHidden = false
            recordsListTableView.isHidden = true
        } else {
            placeholderLabel.isHidden = true
            recordsListTableView.isHidden = false
        }
    }
    
    func displayPermissionToContinueAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message.localized, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelButtonTitle.localized, style: .cancel, handler: nil)
        let continueAction = UIAlertAction(title: continueButtonTitle.localized, style: .default) { _ in
            self.userPermissionTocontinue()
        }
        alert.addAction(cancelAction)
        alert.addAction(continueAction)
        present(alert, animated: false, completion: nil)
    }
    
    func userPermissionTocontinue() {
        
    }
}
