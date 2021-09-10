//
//  User+CoreDataProperties.swift
//  CV_Builder_App
//
//  Created by Mangesh on 09/09/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var dateOfBirth: String?
    @NSManaged public var name: String?
    @NSManaged public var profileImage: Data?
    @NSManaged public var surname: String?
    @NSManaged public var telephone: String?
    @NSManaged public var userDescription: String?
    @NSManaged public var emailAddress: String?
    @NSManaged public var educationDetails: NSSet?
    @NSManaged public var workExperiences: NSSet?

}

// MARK: Generated accessors for educationDetails
extension User {

    @objc(addEducationDetailsObject:)
    @NSManaged public func addToEducationDetails(_ value: Education)

    @objc(removeEducationDetailsObject:)
    @NSManaged public func removeFromEducationDetails(_ value: Education)

    @objc(addEducationDetails:)
    @NSManaged public func addToEducationDetails(_ values: NSSet)

    @objc(removeEducationDetails:)
    @NSManaged public func removeFromEducationDetails(_ values: NSSet)

}

// MARK: Generated accessors for workExperiences
extension User {

    @objc(addWorkExperiencesObject:)
    @NSManaged public func addToWorkExperiences(_ value: WorkExperience)

    @objc(removeWorkExperiencesObject:)
    @NSManaged public func removeFromWorkExperiences(_ value: WorkExperience)

    @objc(addWorkExperiences:)
    @NSManaged public func addToWorkExperiences(_ values: NSSet)

    @objc(removeWorkExperiences:)
    @NSManaged public func removeFromWorkExperiences(_ values: NSSet)

}

extension User : Identifiable {

}

