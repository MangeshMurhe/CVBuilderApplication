//
//  UserCVListViewModel.swift
//  CV_Builder_App
//
//  Created by Mangesh on 08/09/21.
//

import Foundation

final class UserCVListViewModel {
    //MARK:- Properties
    private var userCVs: [User]? {
        didSet {
            if let callback = refreshCallBack {
                callback()
            }
        }
    }
    private var getUserCVsUseCase: FetchUsersCVUseCaseProtocol
    var refreshCallBack:(()->())?
    var educationDetails:[Education] {
        userCVs?[1].educationDetails?.allObjects as? [Education] ?? []
    }
    
    var totalUserCVs: Int {
        return userCVs?.count ?? 0
    }
    
    //MARK:- Initializers
    init(usecase: FetchUsersCVUseCaseProtocol) {
        getUserCVsUseCase = usecase
    }
    
    //MARK:- Data fetch methods
    func fetchUsersCV() {
        getUserCVsUseCase.fetchUsers {[weak self] (users) in
            self?.userCVs = users
        }
    }
    
    func getUserFor(index: Int) -> User? {
        return userCVs?[index]
    }
}
