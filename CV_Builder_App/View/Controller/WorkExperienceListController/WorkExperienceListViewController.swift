//
//  WorkExperienceListVC.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import UIKit

class WorkExperienceListViewController: BaseListViewController {
    
    //MARK:- Properties
    private let cellIdentifier = "recordDetailsCell"
    private let cellNibName = "RecordDetailsCell"
    private var workExperienceListViewModel: WorkExperincesListViewModel
    private lazy var continueMessage = "No work experience added. Would you like to continue?"
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Work Experience".localized
        setUpPlaceHolderText(recordsCount: workExperienceListViewModel.totalWorkExperiences)
        registerTableCellNib(nibName: cellNibName, cellIdentifier: cellIdentifier)
        navigationItem.backButtonTitle = ""
    }
    
    //MARK:- Initializers
    init(viewModel: WorkExperincesListViewModel) {
        workExperienceListViewModel = viewModel
        super.init(nibName: "WorkExperiencesList", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Action methods
    override func addButtonClicked() {
        presentAddWorkExperienceScreen(workExperience: nil)
    }
    
    override func userPermissionTocontinue() {
        moveNextToEducationDetails()
    }
    
    private func presentAddWorkExperienceScreen(workExperience: WorkExperience?) {
        let newWorkExperienceController = AddNewWorkExperienceViewController(viewModel: AddNewWorkExperienceViewModel(useCase: GetWorkExperienceFieldsUseCase(repository: WorkExperienceRepository(context: CoreDataManager.sharedInstance.managedObjectContext)), workExperienceModel: workExperience), workExperienceListViewModel: workExperienceListViewModel)
        newWorkExperienceController.delegate = self
        present(newWorkExperienceController, animated: false, completion: nil)
    }
    
    @IBAction private func nextButtonClicked() {
        if workExperienceListViewModel.totalWorkExperiences == 0 {
             displayPermissionToContinueAlert(message: continueMessage)
        } else {
            moveNextToEducationDetails()
        }
    }
    
    private func moveNextToEducationDetails() {
        ScreenManager.sharedInstance.pushEducationDetailsListController(context: self, viewModel: workExperienceListViewModel)
    }
}

//MARK:- WorkExperienceCreationDelegate protocol requirement implementation
extension WorkExperienceListViewController: WorkExperienceCreationDelegate {
    func workExperienceAddedsuccessfully() {
        setUpPlaceHolderText(recordsCount: workExperienceListViewModel.totalWorkExperiences)
        recordsListTableView.reloadData()
    }
}

//MARK:- Table view data source methods
extension WorkExperienceListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workExperienceListViewModel.totalWorkExperiences
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecordDetailsCell
        if let workExperienceDetails = workExperienceListViewModel.getWorkExperienceAt(index:indexPath.row) {
            cell?.configure(viewModel: WorkExperienceDetailsViewModel(workExperienceDetails: workExperienceDetails), isShowEditOption: true)
        }
        return cell!
    }
}

//MARK:- Tableview delegate methods
extension WorkExperienceListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)      {
        presentAddWorkExperienceScreen(workExperience: workExperienceListViewModel.getWorkExperienceAt(index: indexPath.row))
    }
}
