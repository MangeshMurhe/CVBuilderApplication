//
//  WorkExperienceListVC.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import UIKit

class WorkExperienceListViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var workExperincesListTableView: UITableView!
    var workExperienceListVM: WorkExperincesListViewModel
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Work Experience"
        setUpTopButton()
        // Do any additional setup after loading the view.
    }

    init(viewModel: WorkExperincesListViewModel) {
        workExperienceListVM = viewModel
        super.init(nibName: "WorkExperienceListVC", bundle: Bundle.main)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup methods
    func setUpTopButton() {
        let add = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(newWorkExperienceTapped))
        navigationItem.rightBarButtonItems = [add]
    }

    func setUpPlaceHolderText() {
        
    }
    
   @objc func newWorkExperienceTapped() {
    present(AddNewWorkExperienceViewController(viewModel: AddNewWorkExperienceViewModel(repository: WorkExperienceRepository()), workExperienceListViewModel: workExperienceListVM), animated: false, completion: nil)
   }
}

extension WorkExperienceListViewController: WorkExperienceCreationDelegate {
    func workExperienceAddedsuccessfully() {
        workExperincesListTableView.reloadData()
    }
}

extension WorkExperienceListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workExperienceListVM.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
