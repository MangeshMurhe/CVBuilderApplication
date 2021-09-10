//
//  UserDetailsViewModel.swift
//  CV_Builder_App
//
//  Created by Mangesh on 06/09/21.
//

import Foundation

enum UserDetailsValidationError:Error {
    case mandatoryFieldError
    case emailValidationError
}

final class UserDetailsViewModel {
    //MARK:- Properties
    private var userCV: User?
    private var userDetailsFieldUseCase: UserDetailsFieldUseCaseProtocol
    private var profileImageData: Data?
    private var userDetailFields: [FieldDetails] {
        return userDetailsFieldUseCase.getUserDetailsFields()
    }
    
    //MARK:- Initializers
    init(userFieldsCase: UserDetailsFieldUseCaseProtocol, currentUserCv: User?) {
        userDetailsFieldUseCase = userFieldsCase
        if let user = currentUserCv {
            userCV = user
            populateFieldModelWithExistingData()
        }
    }
    
    //MARK:-
    func isDetailsValid()-> Result<Bool,UserDetailsValidationError> {
        
        let result = userDetailFields.map { fieldDataModel -> Result<Bool,UserDetailsValidationError> in
            if fieldDataModel.isFieldMandatory && fieldDataModel.fieldValue == nil  {
                return .failure(.mandatoryFieldError)
            } else if fieldDataModel.fieldName == FieldNames.email, let email = fieldDataModel.fieldValue, !email.isValidEmail {
                return .failure(.emailValidationError)
            } else {
                return .success(true)
            }
        }
        
        if result.filter({ $0 == .failure(.mandatoryFieldError)}).count > 0 {
            return .failure(.mandatoryFieldError)
        } else if result.filter({ $0 == .failure(.emailValidationError)}).count > 0 {
            return .failure(.emailValidationError)
        } else {
            return .success(true)
        }
    }
    
    func populateFieldModelWithExistingData() {
        _ = userDetailFields.map({ fieldDataModel  in
            fieldDataModel.fieldValue = userCV?.value(forKey: fieldDataModel.fieldName.rawValue) as? String
        })
    }
    
    func saveUserDetails() {
        if let user = userCV {
            userDetailsFieldUseCase.updateExistingUserDetails(currentUser: user)
        } else {
            createNewUser()
        }
        if let user = userCV, let data = profileImageData {
            user.setValue(data, forKey: "profileImage")
        }
    }
    
    func createNewUser() {
        userCV = userDetailsFieldUseCase.createNewUser()
    }
    
    func saveProfileImage(imageData: Data?) {
        profileImageData = imageData
    }
    
    func getFieldsArray() -> [FieldDetails] {
        return userDetailsFieldUseCase.getUserDetailsFields()
    }
    
    func getUserCVDetails() -> User? {
        return userCV
    }
    
    func getProfileImageData() -> Data? {
        return userCV?.profileImage
    }
    
    func getUserFullName() -> String? {
        if let name = userCV?.name, let surname = userCV?.surname {
            return name + " " + surname
        } else {
            return nil
        }
    }
    
    func getEmailDisplayName()-> String? {
        if let emailAddress = userCV?.emailAddress {
            return "Email: \(emailAddress)"
        }
        return nil
    }
    
    func getPhoneNumber()-> String? {
        if let telePhone = userCV?.telephone {
            return "Tel: \(telePhone)"
        }
        return nil
    }
    
    func getDateOfBirth()-> String? {
        if let dateOfBirth = userCV?.dateOfBirth {
            return "DOB: \(dateOfBirth)"
        }
        return nil
    }
    
    func getUserDescription()-> String? {
        return userCV?.userDescription
    }
}
