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

class AddNewWorkExperienceViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var workExperienceDetailsTableView: UITableView!
    
    //MARK:- Variables
    var addWorkExperienceViewModel: AddNewWorkExperienceViewModel
    lazy var workExperienceDataSource = GenericDataSource()
    weak var delegate: WorkExperienceCreationDelegate?
    var workExperinceListVm: WorkExperincesListViewModel
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Work Experience"
        setupDataSource()
        
    }
    
    //MARK:- Initializers
    init(viewModel: AddNewWorkExperienceViewModel, workExperienceListViewModel: WorkExperincesListViewModel) {
        addWorkExperienceViewModel = viewModel
        workExperinceListVm = workExperienceListViewModel
        super.init(nibName: "AddNewWorkExperienceVC", bundle: Bundle.main)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Action methods
    @IBAction func saveWorkExperience() {
        view.endEditing(true)
        addWorkExperienceViewModel.saveWorkExperience()
        workExperinceListVm.addNewWorkExperience(newWorkExperience: addWorkExperienceViewModel.workExperience)
        if let delegateInstance = delegate {
            delegateInstance.workExperienceAddedsuccessfully()
        }
    }

}
//MARK:- Setup methods
extension AddNewWorkExperienceViewController {
    private func setupDataSource() {
        workExperienceDataSource.registerCellWith(tableView: workExperienceDetailsTableView)
        workExperienceDataSource.array = addWorkExperienceViewModel.getAddWorkExperienceFields()
        workExperienceDetailsTableView.dataSource = workExperienceDataSource
        workExperienceDetailsTableView.delegate = workExperienceDataSource
    }
}
