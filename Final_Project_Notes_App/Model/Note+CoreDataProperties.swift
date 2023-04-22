//
//  Note+CoreDataProperties.swift
//  Final_Project_Notes_App
//
//  Created by Anastasia Neagu on 18.04.2023.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var lastEdit: Date?

}

extension Note : Identifiable {

}
