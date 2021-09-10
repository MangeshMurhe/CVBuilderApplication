//
//  CVProfileSummaryController.swift
//  CV_Builder_App
//
//  Created by Mangesh on 08/09/21.
//

import UIKit
import MessageUI

enum ProfileSummarySections: Int {
    case userDetails = 0
    case workExperience
    case educationDetails
}

final class CVProfileSummaryController: UIViewController, MFMailComposeViewControllerDelegate {

    //MARK:- Outlets
    @IBOutlet private weak var cvProfileSummaryTableView: UITableView!
    
    //MARK:- Properties
    private var cvProfileSummaryViewModel: CVProfileSummaryViewModel
    private let userDetailsSummaryCellReuseIdentifier = "userDetailsSummaryCell"
    private let workExperienceDetailsCellReuseIdentifier = "recordDetailsCell"
    private let educationDetailsCellReuseIdentifier = "educationDetailsCell"
    private let sectionHeaderHeight: CGFloat = 30
    private let editButtonTitle = "Edit"
    private let shareButtonTitle = "Share"
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
    
    @objc private func shareButtonClicked() {
        pdfDataWithTableView(tableView: cvProfileSummaryTableView)
        if let pdfData = getUserCVPdfFileData() {
            sendEmail(data: pdfData)
        }
    }
    
    //MARK:- Setup methods
    private func registerDetailCells() {
        cvProfileSummaryTableView.register(UINib(nibName: "CVUserDetailsSummaryCell", bundle: nil), forCellReuseIdentifier: userDetailsSummaryCellReuseIdentifier)
        cvProfileSummaryTableView.register(UINib(nibName: "RecordDetailsCell", bundle: nil), forCellReuseIdentifier: workExperienceDetailsCellReuseIdentifier)
        cvProfileSummaryTableView.register(UINib(nibName: "EducationDetailsCell", bundle: nil), forCellReuseIdentifier: educationDetailsCellReuseIdentifier)
    }
    
    private func setUpTopButton() {
        let editButton = UIBarButtonItem(title: editButtonTitle.localized, style: .plain, target: self, action: #selector(editButtonTapped))
        let shareButton = UIBarButtonItem(title: shareButtonTitle.localized, style: .plain, target: self, action: #selector(shareButtonClicked))
        editButton.tintColor = UIColor.label
        shareButton.tintColor = UIColor.label
        navigationItem.rightBarButtonItems = [editButton]
        navigationItem.leftBarButtonItem = shareButton
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

//MARK:- Share methods
extension CVProfileSummaryController: AlertDisplayProtocol {
    
    private func pdfDataWithTableView(tableView: UITableView) {
        let priorBounds = tableView.bounds
        let fittedSize = tableView.sizeThatFits(CGSize(width:priorBounds.size.width, height:tableView.contentSize.height))
        tableView.bounds = CGRect(x:0, y:0, width:fittedSize.width, height:fittedSize.height)
        let pdfPageBounds = CGRect(x:0, y:0, width:tableView.frame.width, height:self.view.frame.height)
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds,nil)
        var pageOriginY: CGFloat = 0
        while pageOriginY < fittedSize.height {
            UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
            UIGraphicsGetCurrentContext()!.saveGState()
            UIGraphicsGetCurrentContext()!.translateBy(x: 0, y: -pageOriginY)
            tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
            UIGraphicsGetCurrentContext()!.restoreGState()
            pageOriginY += pdfPageBounds.size.height
        }
        UIGraphicsEndPDFContext()
        tableView.bounds = priorBounds
        if let path = getPdfFilePath(), pdfData.write(to:path, atomically: true) {
            print("File written at path:\(path.absoluteString)")
        }
    }
    
    private func getPdfFilePath()-> URL? {
        var pdfURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        if let userName = cvProfileSummaryViewModel.getUserNameToSavePdf() {
            pdfURL = pdfURL.appendingPathComponent("\(userName).pdf")
        } else {
            pdfURL = pdfURL.appendingPathComponent("userCV.pdf")
        }
        return pdfURL
    }
    
    private func getUserCVPdfFileData() -> Data? {
        if let filePath = getPdfFilePath(), FileManager.default.fileExists(atPath: filePath.path) {
            return  try? Data(contentsOf: filePath)
        }
        return nil
    }
    
    private func removeUserCVPdfFile() {
        if  let filePath = getPdfFilePath(), FileManager.default.fileExists(atPath: filePath.path) {
           try? FileManager.default.removeItem(atPath: filePath.path)
        }
    }
    
    func sendEmail(data:Data?) {
        if(MFMailComposeViewController.canSendMail()) {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            if let emailAddress = cvProfileSummaryViewModel.getUserCVDetail().emailAddress {
                mailComposer.setToRecipients([emailAddress])
            }
            var userCVFileName = "CV"
            if let fileName = cvProfileSummaryViewModel.getUserNameToSavePdf() {
                userCVFileName = fileName
                mailComposer.setSubject(fileName)
            }
            if let fileData = data {
                mailComposer.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "\(userCVFileName).pdf")
            }
            removeUserCVPdfFile()
            self.present(mailComposer, animated: true, completion: nil)
        } else {
            displayAlert(message: "Failed to send email".localized, context: self)
            removeUserCVPdfFile()
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
