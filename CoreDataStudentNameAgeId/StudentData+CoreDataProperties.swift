//
//  StudentData+CoreDataProperties.swift
//  CoreDataStudentNameAgeId
//
//  Created by Admin on 01/03/23.
//
//

import Foundation
import CoreData


extension StudentData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentData> {
        return NSFetchRequest<StudentData>(entityName: "StudentData")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var rollNumber: Int64

}

extension StudentData : Identifiable {

}
