//
//  WorkExperience+CoreDataProperties.swift
//  CV_Builder_App
//
//  Created by Mangesh on 09/09/21.
//
//

import Foundation
import CoreData


extension WorkExperience {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkExperience> {
        return NSFetchRequest<WorkExperience>(entityName: "WorkExperience")
    }

    @NSManaged public var companyName: String?
    @NSManaged public var designation: String?
    @NSManaged public var from: String?
    @NSManaged public var jobDescription: String?
    @NSManaged public var toDate: String?
    @NSManaged public var user: User?

}

extension WorkExperience : Identifiable {
    static func ==(lhs:WorkExperience, rhs: WorkExperience)-> Bool {
        return lhs.companyName == rhs.companyName && lhs.designation == rhs.designation
    }
}
