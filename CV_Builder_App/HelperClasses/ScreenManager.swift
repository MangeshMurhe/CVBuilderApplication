//
//  ScreenManager.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//

import UIKit

final class ScreenManager {
    static let sharedInstance = ScreenManager()
    
    private init() {}
    
    func pushUserDetailsController(context: UIViewController, userDetailViewModel:UserDetailsViewModel) {
        let navigationController = context.navigationController
        popViewControllers(navigationController: navigationController)
        navigationController?.pushViewController(UserDetailsControllerViewController(viewModel: userDetailViewModel), animated: false)
    }
    
    func pushWorkExperienceListController(context: UIViewController, viewModel: UserDetailsViewModel) {
        if let userDetails = viewModel.getUserCVDetails() {
        context.navigationController?.pushViewController(WorkExperienceListViewController(viewModel: WorkExperincesListViewModel(user: userDetails)), animated: false)
        }
    }
    
    func pushEducationDetailsListController(context: UIViewController, viewModel: WorkExperincesListViewModel) {
        context.navigationController?.pushViewController(EducationDetailsListController(viewModel: EducationDetailsListViewModel(user: viewModel.getUserDetails())), animated: false)
    }
    
    func pushCVProfileSummaryViewController(context: UIViewController, viewModel: CVProfileSummaryViewModel) {
        let navigationController = context.navigationController
        popViewControllers(navigationController: navigationController)
        navigationController?.pushViewController(CVProfileSummaryController(viewModel: viewModel), animated: false)
    }
    
    func popViewControllers(navigationController:UINavigationController?) {
        navigationController?.popToRootViewController(animated: false)
    }
}
