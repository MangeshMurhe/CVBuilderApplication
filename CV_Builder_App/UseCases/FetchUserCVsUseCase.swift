//
//  FetchUserCVsUseCase.swift
//  CV_Builder_App
//
//  Created by Mangesh on 08/09/21.
//
import Foundation

enum DataFetchError: Error {
    case fetchError(Error)
}

protocol FetchUsersCVUseCaseProtocol {
    func fetchUsers(completion:@escaping (([User])->()))
}

final class FetchUserCVsUseCase: FetchUsersCVUseCaseProtocol {
    private var userRepository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol) {
        userRepository = repository
    }
    
    func fetchUsers(completion:@escaping (([User])->())) {
        userRepository.getUserDetails() { users in
            completion(users)
        }
    }
}
