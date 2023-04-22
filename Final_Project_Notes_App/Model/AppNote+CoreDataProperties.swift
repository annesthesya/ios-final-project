//
//  AppNote+CoreDataProperties.swift
//  Final_Project_Notes_App
//
//  Created by Anastasia Neagu on 18.04.2023.
//
//

import Foundation
import CoreData


extension AppNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppNote> {
        return NSFetchRequest<AppNote>(entityName: "AppNote")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var lastEdit: NSObject?

}

extension AppNote : Identifiable {

}
