// Not in use but can be added to save state and persist application
import Foundation
import CoreData

class Persistence {

    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    static func saveContext () {
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
    
    // MARK: - Core Data stack

    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Connect4")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

}
