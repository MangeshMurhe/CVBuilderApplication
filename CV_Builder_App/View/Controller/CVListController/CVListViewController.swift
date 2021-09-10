//
//  CVListViewController.swift
//  CV_Builder_App
//
//  Created by Mangesh on 06/09/21.
//

import UIKit

final class CVListViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet private weak var cvListTableView: UITableView! {
        didSet {
            cvListTableView.register(UINib(nibName: "CVListTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    //MARK:- Properties
    private var userCVListViewModel: UserCVListViewModel
    private let cellIdentifier = "cvListCell"
    private let cvListCellHeight: CGFloat = 80
    
    //MARK:- Initializers
    init(viewModel: UserCVListViewModel) {
        userCVListViewModel = viewModel
        super.init(nibName: "CVListViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTopButton()
        initializeViewModelCallbacks()
        self.navigationController?.navigationBar.tintColor = UIColor.label
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchExistingUserCV()
    }
    
    //MARK:- Setup methods
    private func setUpTopButton() {
        let newCVButton = UIButton(type: .system)
        newCVButton.setImage(UIImage(systemName: "doc.fill.badge.plus"), for: .normal)
        newCVButton.setTitle("New CV".localized, for: .normal)
        newCVButton.setTitleColor(UIColor.label, for: .normal)
        newCVButton.tintColor = newCVButton.titleColor(for: .normal)
        newCVButton.sizeToFit()
        newCVButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        newCVButton.addTarget(self, action: #selector(newCvTapped), for: .touchUpInside)
        let  newCVBarButton = UIBarButtonItem(customView: newCVButton)
        navigationItem.rightBarButtonItems = [newCVBarButton]
    }
    
    private func initializeViewModelCallbacks() {
        userCVListViewModel.refreshCallBack = {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.cvListTableView.reloadData()
        }
    }
    
    private func fetchExistingUserCV() {
        userCVListViewModel.fetchUsersCV()
    }

    //MARK:- Action methods
    @objc func newCvTapped() {
        ScreenManager.sharedInstance.pushUserDetailsController(context: self, userDetailViewModel: UserDetailsViewModel(userFieldsCase: GetUserDetailsFieldUseCase(repository: UserRepository(context: CoreDataManager.sharedInstance.managedObjectContext)), currentUserCv: nil))
     }
}

//MARK:- Table view datasource methods
extension CVListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCVListViewModel.totalUserCVs
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CVListTableViewCell
        cell?.setUpUserDetails(viewModel: UserDetailsViewModel(userFieldsCase: GetUserDetailsFieldUseCase(repository: UserRepository(context: CoreDataManager.sharedInstance.managedObjectContext)), currentUserCv: userCVListViewModel.getUserFor(index: indexPath.row)))
        return cell!
    }
}

//MARK:- Table view delegate methods
extension CVListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cvListCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let userCv = userCVListViewModel.getUserFor(index: indexPath.row) {
        ScreenManager.sharedInstance.pushCVProfileSummaryViewController(context: self, viewModel: CVProfileSummaryViewModel(userCVDetails: userCv))
        }
    }
}
