//
//  CVProfileSummaryController.swift
//  CV_Builder_App
//
//  Created by Mangesh on 08/09/21.
//

import UIKit

enum ProfileSummarySections: Int {
    case userDetails = 0
    case workExperience
    case educationDetails
}

final class CVProfileSummaryController: UIViewController {

    //MARK:- Outlets
    @IBOutlet private weak var cvProfileSummaryTableView: UITableView!
    
    //MARK:- Properties
    private var cvProfileSummaryViewModel: CVProfileSummaryViewModel
    private let userDetailsSummaryCellReuseIdentifier = "userDetailsSummaryCell"
    private let workExperienceDetailsCellReuseIdentifier = "recordDetailsCell"
    private let educationDetailsCellReuseIdentifier = "educationDetailsCell"
    private let sectionHeaderHeight: CGFloat = 30
    private let editButtonTitle = "Edit"
    //MARK:- Initializers
    init(viewModel: CVProfileSummaryViewModel) {
        cvProfileSummaryViewModel = viewModel
        super.init(nibName: "CVProfileSummaryController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDetailCells()
        setUpTopButton()
        navigationItem.hidesBackButton = true
    }
    
    //MARK:- Action methods
    @IBAction func doneButtonClicked() {
        ScreenManager.sharedInstance.popViewControllers(navigationController: self.navigationController)
    }
    
    @objc private func editButtonTapped() {
        ScreenManager.sharedInstance.pushUserDetailsController(context: self, userDetailViewModel: UserDetailsViewModel(userFieldsCase: GetUserDetailsFieldUseCase(repository: UserRepository(context: CoreDataManager.sharedInstance.managedObjectContext)), currentUserCv: cvProfileSummaryViewModel.getUserCVDetail()))
     }

    //MARK:- Setup methods
    private func registerDetailCells() {
        cvProfileSummaryTableView.register(UINib(nibName: "CVUserDetailsSummaryCell", bundle: nil), forCellReuseIdentifier: userDetailsSummaryCellReuseIdentifier)
        cvProfileSummaryTableView.register(UINib(nibName: "RecordDetailsCell", bundle: nil), forCellReuseIdentifier: workExperienceDetailsCellReuseIdentifier)
        cvProfileSummaryTableView.register(UINib(nibName: "EducationDetailsCell", bundle: nil), forCellReuseIdentifier: educationDetailsCellReuseIdentifier)
    }
    
    private func setUpTopButton() {
        let editButton = UIBarButtonItem(title: editButtonTitle.localized, style: .plain, target: self, action: #selector(editButtonTapped))
        editButton.tintColor = UIColor.label
        navigationItem.rightBarButtonItems = [editButton]
    }
}

//MARK:- Table view data source nethods
extension CVProfileSummaryController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cvProfileSummaryViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case ProfileSummarySections.userDetails.rawValue:
            return 1
        case ProfileSummarySections.workExperience.rawValue:
            return  cvProfileSummaryViewModel.getTotalWorkExperiences()
        case ProfileSummarySections.educationDetails.rawValue:
            return cvProfileSummaryViewModel.getTotalEducationDetails()
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case ProfileSummarySections.userDetails.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: userDetailsSummaryCellReuseIdentifier, for: indexPath) as? CVUserDetailsSummaryCell
            cell?.configureCell(viewModel: UserDetailsViewModel(userFieldsCase: GetUserDetailsFieldUseCase(repository: UserRepository(context: CoreDataManager.sharedInstance.managedObjectContext)), currentUserCv: cvProfileSummaryViewModel.getUserCVDetail()))
            return cell!
        case ProfileSummarySections.workExperience.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: workExperienceDetailsCellReuseIdentifier, for: indexPath) as? RecordDetailsCell
            if let workExperienceDetails = cvProfileSummaryViewModel.getWorkExperienceAt(index:indexPath.row) {
                cell?.configure(viewModel: WorkExperienceDetailsViewModel(workExperienceDetails: workExperienceDetails ))
            }
            return cell!
        case ProfileSummarySections.educationDetails.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: educationDetailsCellReuseIdentifier, for: indexPath) as? EducationDetailsCell
            if let education = cvProfileSummaryViewModel.getEducationAt(index: indexPath.row) {
                cell?.configureCell(viewModel: EducationDetailViewModel(educationDetails: education))
            }
            
            return cell!
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: sectionHeaderHeight))
            let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: headerView.frame.width, height: headerView.frame.height))
            titleLabel.text = cvProfileSummaryViewModel.sections[section].localized
            headerView.addSubview(titleLabel)
            headerView.bringSubviewToFront(titleLabel)
            headerView.backgroundColor = .lightGray
            return headerView
        }
        return nil
    }
}

//MARK:- Table view data source nethods
extension CVProfileSummaryController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
           return sectionHeaderHeight
        }
    }
}
