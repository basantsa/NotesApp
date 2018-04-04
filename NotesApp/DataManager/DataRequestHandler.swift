//
//  DataRequestHandler.swift
//  NotesApp
//
//  Created by Basant Sarda on 04/04/18.
//  Copyright © 2018 Basant. All rights reserved.
//

import UIKit
import CoreData

protocol DataRequestHandlerDelegate {
    func notesUpdated()
}

class DataRequestHandler: NSObject, NSFetchedResultsControllerDelegate {
    
    static let sharedInstance = DataRequestHandler()

    var dataRequestHandlerDelegate:DataRequestHandlerDelegate!
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dataRequestHandlerDelegate.notesUpdated()
    }
    
    func fetchAllNotes() -> [Note] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        let creationDateSort = NSSortDescriptor(key: "noteCreationDate", ascending: false)
        request.sortDescriptors = [creationDateSort]
        
        let moc = CoreDataManager.sharedInstance.persistentContainer.viewContext
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            return fetchedResultsController.fetchedObjects as! [Note]
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    func deleteNote(note:Note) {
        CoreDataManager.sharedInstance.persistentContainer.viewContext.delete(note)
        do {
            try CoreDataManager.sharedInstance.persistentContainer.viewContext.save()
        } catch {
            // Do something... fatalerror
        }
    }
    
    func createNewNote(noteStr:String) {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: CoreDataManager.sharedInstance.persistentContainer.viewContext) as! Note
        note.noteText = noteStr
        note.noteCreationDate = Date()
        note.noteID = String(NSDate().timeIntervalSince1970)
        CoreDataManager.sharedInstance.saveContext()
    }
    
    func save() {
        do {
            try CoreDataManager.sharedInstance.persistentContainer.viewContext.save()
        } catch {
            // Do something... fatalerror
        }
    }
    
}
