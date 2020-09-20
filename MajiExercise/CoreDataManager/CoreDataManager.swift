//
//  CoreDataManager.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    static let shared = CoreDataManager()

    lazy  var context: NSManagedObjectContext = {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
        return context
    }()
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // add a history data
    func saveHistoryDataWith(history:History) {
        saveContext()
    }
    
    // get all history data
    func getAllHistory() -> [History] {
        let fetchRequest: NSFetchRequest = History.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError();
        }
    }
    
    // delete a history data
    func deleteHistoryDataWith(timeLine: String) {
        let fetchRequest: NSFetchRequest = History.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "timeLine == %@", timeLine)
        do {
            let result = try context.fetch(fetchRequest)
            for history in result {
                context.delete(history)
            }
        } catch {
            fatalError();
        }
        saveContext()
    }
    
    // delete all history data
    func deleteAllHistory() {
        let result = getAllHistory()
        for history in result {
            context.delete(history)
        }
        saveContext()
    }
}
