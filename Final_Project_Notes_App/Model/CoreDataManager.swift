//
//  CoreDataManager.swift
//  Final_Project_Notes_App
//
//  Created by Anastasia Neagu on 19.04.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "AppNote")
    
    let persistentContainer : NSPersistentContainer
    var viewContext : NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    init(modelName : String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil){
        persistentContainer.loadPersistentStores {(description, error) in
        guard error == nil else{
            fatalError(error!.localizedDescription)
            }
            completion?()
        }
        
    }
    
    func save(){
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            }catch{
                print("An error has occurred: \(error.localizedDescription)")
            }
        }
    }
    
}

// MARK: Helper functions

extension CoreDataManager {
    
    func createNote() -> AppNote {
        let note = AppNote(context: CoreDataManager.shared.viewContext)
        note.id = UUID()
        note.lastEdit = Date()
        note.title = ""
        note.text = ""
        save()
        return note
    }
    
    func fetchNotes() -> [AppNote] {
        let request : NSFetchRequest<AppNote> = AppNote.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \AppNote.lastEdit, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {return try viewContext.fetch(request) }
        catch{
            print("Error when fetching: \(error.localizedDescription)")
            return []
        }
    }
    
    func updateNote(note: AppNote,title: String, text: String) -> Void{
        note.title = title
        note.text = text
        note.lastEdit = Date()
        save()
    }
    
    func deleteNote(note: AppNote){
        viewContext.delete(note)
        save()
    }
    
}
