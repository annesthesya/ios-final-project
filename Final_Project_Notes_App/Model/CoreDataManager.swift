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
    
    func fetchNotes(filter: String? = nil) -> [AppNote] {
        let request: NSFetchRequest<AppNote> = AppNote.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \AppNote.lastEdit, ascending: false)
        request.sortDescriptors = [sortDescriptor]
            
        if let filter = filter {
            let predicate_text = NSPredicate(format: "text contains[cd] %@", filter)
            let predicate_title = NSPredicate(format: "title contains[cd] %@", filter)
            let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate_text, predicate_title])
            request.predicate = predicate
        }
            
        return (try? viewContext.fetch(request)) ?? []
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
