//
//  AddNewEducationDetailsController.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import UIKit

protocol EducationDetailCreatedDelegate: class {
    func educationDetailsAddedsuccessfully()
}

final class AddNewEducationDetailsController: AddNewRecordBaseViewController, AlertDisplayProtocol {
    
    //MARK:- Properties
    private var addEducationDetailViewModel: AddNewEducationDetailViewModel
    weak var delegate: EducationDetailCreatedDelegate?
    private var educationDetailsListViewModel: EducationDetailsListViewModel
    
    //MARK:- Initializers
    init(viewModel: AddNewEducationDetailViewModel, educationListsViewModel: EducationDetailsListViewModel) {
        addEducationDetailViewModel = viewModel
        educationDetailsListViewModel = educationListsViewModel
        super.init(nibName: "AddNewEducationDetailsController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        genericDataSource.array = addEducationDetailViewModel.getEducationDetailsFields()
    }
    
    //MARK:- Action methods
    @IBAction func saveEducationDetail() {
        view.endEditing(true)
        if addEducationDetailViewModel.isValidDetails() {
            addEducationDetailViewModel.saveEducationDetail()
            educationDetailsListViewModel.addNewEducation(newEducationDetails: addEducationDetailViewModel.getNewlyAddedEducation())
            if let delegateInstance = delegate {
                delegateInstance.educationDetailsAddedsuccessfully()
            }
            closeForm()
        } else {
            displayAlert(message: "Please fill all the mandatory fields detail", context: self)
        }
    }
}
