//
//  Contact+CoreDataProperties.swift
//  AppleContacts
//
//  Created by 김혜수 on 2021/09/28.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var job: String

}

extension Contact : Identifiable {

}
