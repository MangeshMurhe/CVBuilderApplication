//
//  AddNewWorkExperienceVC.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import UIKit

protocol WorkExperienceCreationDelegate: class {
    func workExperienceAddedsuccessfully()
}

class AddNewWorkExperienceViewController: AddNewRecordBaseViewController, AlertDisplayProtocol {
    
    //MARK:- Properties
    var addWorkExperienceViewModel: AddNewWorkExperienceViewModel
    weak var delegate: WorkExperienceCreationDelegate?
    var workExperinceListVm: WorkExperincesListViewModel
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        genericDataSource.array = addWorkExperienceViewModel.getAddWorkExperienceFields()
        title = "Add Work Experience"
    }
    
    //MARK:- Initializers
    init(viewModel: AddNewWorkExperienceViewModel, workExperienceListViewModel: WorkExperincesListViewModel) {
        addWorkExperienceViewModel = viewModel
        workExperinceListVm = workExperienceListViewModel
        super.init(nibName: "AddNewWorkExperience", bundle: Bundle.main)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Action methods
    @IBAction func saveWorkExperience() {
        view.endEditing(true)
        if addWorkExperienceViewModel.isValidDetails() {
            addWorkExperienceViewModel.saveWorkExperience()
            workExperinceListVm.addNewWorkExperience(newWorkExperience: addWorkExperienceViewModel.getWorkExperience())
            if let delegateInstance = delegate {
                delegateInstance.workExperienceAddedsuccessfully()
            }
            closeForm()
        } else {
            displayAlert(message: "Please fill all the mandatory fields detail", context: self)
        }
    }
}
