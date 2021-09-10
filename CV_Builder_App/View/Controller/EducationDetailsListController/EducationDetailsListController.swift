//
//  EducationDetailsListController.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import UIKit

final class EducationDetailsListController: BaseListViewController {

    //MARK:- Properties
    private var educationListViewModel: EducationDetailsListViewModel
    private let cellIdentifier = "educationDetailsCell"
    private let cellNibName = "EducationDetailsCell"
    private lazy var continueMessage = "No education added. Would you like to continue?"
    
    //MARK:- Initializers
    init(viewModel: EducationDetailsListViewModel) {
        educationListViewModel = viewModel
        super.init(nibName: "EducationDetailsListController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPlaceHolderText(recordsCount: educationListViewModel.totalEducationDetails)
        registerTableCellNib(nibName: cellNibName, cellIdentifier: cellIdentifier)
        title = "Education".localized
        navigationItem.backButtonTitle = ""
    }

    //MARK:- Action methods
    override func addButtonClicked() {
        presentAddNewEducationDetailsScreen(educationDetail: nil)
    }
    
    override func userPermissionTocontinue() {
        continueSubmitAction()
    }
    
    @IBAction func nextButtonClicked() {
        if educationListViewModel.totalEducationDetails == 0 {
            displayPermissionToContinueAlert(message: continueMessage)
        } else {
            continueSubmitAction()
        }
    }
    
    private func continueSubmitAction() {
        educationListViewModel.saveUserCVDetails()
        ScreenManager.sharedInstance.pushCVProfileSummaryViewController(context: self, viewModel: CVProfileSummaryViewModel(userCVDetails: educationListViewModel.getCurrentUserCV()))
    }
    
    private func presentAddNewEducationDetailsScreen(educationDetail: Education?) {
        let addEducationController = AddNewEducationDetailsController(viewModel: AddNewEducationDetailViewModel(useCase: GetEducationDetailsFieldUseCase(repository: EducationRepository(context: CoreDataManager.sharedInstance.managedObjectContext)), educationModel: educationDetail), educationListsViewModel: educationListViewModel)
           addEducationController.delegate = self
        present(addEducationController, animated: false, completion: nil)
    }
}

//MARK:- EducationDetailCreatedDelegate requirement implementation
extension EducationDetailsListController: EducationDetailCreatedDelegate {
    func educationDetailsAddedsuccessfully() {
        setUpPlaceHolderText(recordsCount: educationListViewModel.totalEducationDetails)
        recordsListTableView.reloadData()
    }    
}

//MARK:- Tableview data source methods
extension EducationDetailsListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return educationListViewModel.totalEducationDetails
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EducationDetailsCell
        if let education = educationListViewModel.getEducationDetailsAt(index: indexPath.row) {
            cell?.configureCell(viewModel: EducationDetailViewModel(educationDetails: education), isShowEditOption: true)
        }
        return cell!
    }
}

//MARK:- Tableview delegate methods
extension EducationDetailsListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)      {
        presentAddNewEducationDetailsScreen(educationDetail: educationListViewModel.getEducationDetailsAt(index: indexPath.row))
    }
}
