//
//  DataStoreManager.swift
//  hw26
//
//  Created by Panda on 18.08.2022.
//

import UIKit
import CoreData

class DataStoreManager {
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "hw26")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func obtainMainUser() -> User {
        let user = User(context: viewContext)
        user.name = "Ivan Petrov"
        let dateFormatter = DateFormatter()
        let dateBirthday = "21/05/1993"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        user.birthday = dateFormatter.date(from: dateBirthday)
        
        do {
            try viewContext.save()
        } catch let error {
                print("Error: \(error)")
        }
        return user
    }
    
//    func updateMainUser(with name: String, birthday: String) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        fetchRequest.predicate = NSPredicate(format: "name = ")
//    }
}
