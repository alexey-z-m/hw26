//
//  User+CoreDataProperties.swift
//  
//
//  Created by Panda on 26.08.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var birthday: Date?
    @NSManaged public var gender: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var image: Data?

}
