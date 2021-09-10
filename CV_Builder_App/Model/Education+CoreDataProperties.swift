//
//  Education+CoreDataProperties.swift
//  CV_Builder_App
//
//  Created by Mangesh on 09/09/21.
//
//

import Foundation
import CoreData


extension Education {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Education> {
        return NSFetchRequest<Education>(entityName: "Education")
    }

    @NSManaged public var descriptionDetails: String?
    @NSManaged public var from: String?
    @NSManaged public var instituteName: String?
    @NSManaged public var toDate: String?
    @NSManaged public var degreeName: String?
    @NSManaged public var user: User?

}

extension Education : Identifiable {

}
