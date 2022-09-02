//
//  CoreDataManager.swift
//  ElectricList
//
//  Created by Denis Polishchuk on 27.07.2022.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ElectricList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//MARK: - Create -
extension CoreDataManager {
    func createSwitcher() -> Switcher {
        let objc = Switcher(context: persistentContainer.viewContext)
        return objc
    }
    
    func createRoom() -> Room {
        let objc = Room(context: persistentContainer.viewContext)
        return objc
    }
    
    func createPoint(room: Room) -> Point {
        let objc = Point(context: persistentContainer.viewContext)
        room.addToPoints(objc)
        saveContext()
        return objc
    }
}

//MARK: - Get -
extension CoreDataManager {
    func getSwitherList() -> [Switcher] {
        let fetchRequest = NSFetchRequest<Switcher>(entityName: "Switcher")
        do {
            let switchers = try persistentContainer.viewContext.fetch(fetchRequest)
            return switchers
        } catch {
            fatalError()
        }
    }
    
    func getRooms() -> [Room] {
        let fetchRequest = NSFetchRequest<Room>(entityName: "Room")
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Room.name), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let objc = try persistentContainer.viewContext.fetch(fetchRequest)
            return objc
        } catch {
            fatalError()
        }
    }
    
    func getPoints(room: Room) -> [Point] {
        let fetchRequest = NSFetchRequest<Point>(entityName: "Point")
        let predicate = NSPredicate(format: "room == %@", room)
        fetchRequest.predicate = predicate
        do {
            let points = try persistentContainer.viewContext.fetch(fetchRequest)
            return points
        } catch {
            fatalError()
        }
    }
}

//MARK: - Delete -
extension CoreDataManager {
    func delete(swither: Switcher) {
        persistentContainer.viewContext.delete(swither)
        saveContext()
    }
    
    func delete(room: Room) {
        persistentContainer.viewContext.delete(room)
        saveContext()
    }
    
    func delete(point: Point) {
        persistentContainer.viewContext.delete(point)
        saveContext()
    }
}
