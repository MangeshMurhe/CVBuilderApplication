//
//  GetUserDetailsFieldUseCase.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//
import Foundation

protocol UserDetailsFieldUseCaseProtocol {
    func getUserDetailsFields()-> [FieldDetails]
    func updateExistingUserDetails(currentUser: User)
    func createNewUser() -> User
}

class GetUserDetailsFieldUseCase:UserDetailsFieldUseCaseProtocol {
    var userRepository: UserRepositoryProtocol
    private let fieldsArray = [FieldDetails(displayName: "Name", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.name, value: nil, isMandatoryField: true), FieldDetails(displayName: "Surname", fieldTypeNme: .normalTextField, fieldAttributeName: FieldNames.surname, value: nil, isMandatoryField: true), FieldDetails(displayName: "Email", fieldTypeNme: .normalTextField, fieldAttributeName: FieldNames.email, value: nil, isMandatoryField: true), FieldDetails(displayName: "Telephone", fieldTypeNme: .normalTextField, fieldAttributeName: FieldNames.telephone, value: nil, isMandatoryField: true), FieldDetails(displayName: "Date of Birth", fieldTypeNme: .dropDownTextField, fieldAttributeName: FieldNames.DateOfBirth, value: nil, isMandatoryField: true), FieldDetails(displayName: "Description", fieldTypeNme: .normalTextField, fieldAttributeName: FieldNames.userDescription, value: nil)]
    
    init(repository: UserRepositoryProtocol) {
        userRepository = repository
    }
    
    func getUserDetailsFields() -> [FieldDetails]  {
        return fieldsArray
    }
    
    func updateExistingUserDetails(currentUser: User) {
        userRepository.updateExistingUserCV(fields: fieldsArray, currentUser: currentUser)
    }
    
    func createNewUser() -> User {
        userRepository.createNewUserCV(fields: fieldsArray)
    }
}

//MARK:- Mock class
class MockUserDetailsFieldUseCase: GetUserDetailsFieldUseCase  {
    private let fieldsArray = [FieldDetails(displayName: "Name", fieldTypeNme: FieldType.normalTextField, fieldAttributeName: FieldNames.name, value: "Mangesh", isMandatoryField: true), FieldDetails(displayName: "Surname", fieldTypeNme: .normalTextField, fieldAttributeName: FieldNames.surname, value: "Murhe", isMandatoryField: true), FieldDetails(displayName: "Email", fieldTypeNme: .normalTextField, fieldAttributeName: FieldNames.email, value: "mangesh78@gmail.com", isMandatoryField: false), FieldDetails(displayName: "Date of Birth", fieldTypeNme: .dropDownTextField, fieldAttributeName: FieldNames.DateOfBirth, value: "31/07/1992", isMandatoryField: true), FieldDetails(displayName: "Description", fieldTypeNme: .normalTextField, fieldAttributeName: FieldNames.userDescription, value: nil)]
    
    override func getUserDetailsFields() -> [FieldDetails] {
        return fieldsArray
    }
    
    override func createNewUser() -> User {
        userRepository.createNewUserCV(fields: fieldsArray)
    }
    
    override func updateExistingUserDetails(currentUser: User) {
        userRepository.updateExistingUserCV(fields: fieldsArray, currentUser: currentUser)
    }
}
