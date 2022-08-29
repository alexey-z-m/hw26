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

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addUser(name: String) {
        let user = User(context: viewContext)
        user.name = name
        user.id = UUID()
        saveContext()
    }
    
    func deleteUser(id: String) {
        guard let user = getUsersById(id: id) else { return }
        viewContext.delete(user)
        saveContext()
    }
    
    func getAllUsers() -> [User] {
        var users = [User]()
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            users = try viewContext.fetch(fetchRequest) as [User]
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return users
    }
    
    func getUsersById(id: String) -> User? {
        var user = [User]()
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        do {
            user = try viewContext.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return user.first
    }
    
    func updateUser(id: String, name: String, birthday: String, gender: String, image: Data?) {
        guard let user = getUsersById(id: id) else { return }
        user.name = name
        user.birthday = birthday.convertToDate()
        user.gender = gender
        user.image = image
        saveContext()
    }
}
