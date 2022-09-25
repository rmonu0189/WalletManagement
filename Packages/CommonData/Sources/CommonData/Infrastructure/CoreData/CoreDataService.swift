import CoreData
import Foundation

public protocol CoreDataServiceProtocol {
    func createModel<T: NSManagedObject>() -> T
    func getRecord<T: NSManagedObject>(for uuid: String) -> T?
    func getRecords<T: NSManagedObject>(_ type: T.Type, predecate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [T]
    func saveContext()
    func deleteRecord(of object: NSManagedObject)
}

public final class CoreDataService: CoreDataServiceProtocol {
    private let databaseName: String
    private lazy var persistentContainer: NSPersistentContainer = newPersistentContainer()

    private lazy var viewContext: NSManagedObjectContext = {
        self.persistentContainer.viewContext
    }()

    private lazy var backgroundContext: NSManagedObjectContext = {
        self.persistentContainer.newBackgroundContext()
    }()

    public init(databaseName: String) {
        self.databaseName = databaseName
    }
}

public extension CoreDataService {
    func createModel<T: NSManagedObject>() -> T {
        guard let entity = NSEntityDescription.entity(forEntityName: String(describing: T.self), in: viewContext) else {
            fatalError("\(String(describing: T.self)) - Entity not found.")
        }
        guard let object = NSManagedObject(entity: entity, insertInto: viewContext) as? T else {
            fatalError("\(String(describing: T.self)) - Error while creating new object.")
        }
        return object
    }

    func saveContext() {
        saveContext(nil)
    }

    private func newPersistentContainer() -> NSPersistentContainer {
        let modelURL = Bundle.module.url(forResource: "WalletManager", withExtension: ".momd")!
        let model = NSManagedObjectModel(contentsOf: modelURL)!
        let container = NSPersistentContainer(name: databaseName, managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error {
                print("CoreData error \(error), \(String(describing: error._userInfo))")
            } else {
                container.viewContext.automaticallyMergesChangesFromParent = true
            }
        })
        return container
    }
}

public extension CoreDataService {
    func saveContext(_ handler: ((_ error: Error?) -> Void)? = nil) {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                handler?(nil)
            } catch {
                handler?(error)
            }
        } else {
            handler?(nil)
        }
    }

    func getRecord<T: NSManagedObject>(for uuid: String) -> T? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
        request.predicate = NSPredicate(format: "uuid = %@", uuid)
        do {
            if let results = try viewContext.fetch(request) as? [T] {
                return results.first
            }
        } catch {
            print("Failed to fetch  \(error)")
        }
        return nil
    }

    func getRecords<T: NSManagedObject>(
        _ type: T.Type,
        predecate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil
    ) -> [T] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
        if let predecate = predecate {
            request.predicate = predecate
        }
        if let descriptors = sortDescriptors { request.sortDescriptors = descriptors }
        do {
            if let results = try viewContext.fetch(request) as? [T] {
                return results
            }
        } catch {
            print("Failed to fetch  \(error)")
        }
        return []
    }

    func deleteRecord(of object: NSManagedObject) {
        viewContext.delete(object)
        saveContext()
    }

    func clearCoreDataStore(_ completion: @escaping (Bool) -> Void) {
        do {
            for i in 0 ..< persistentContainer.managedObjectModel.entities.count {
                let entity = persistentContainer.managedObjectModel.entities[i]
                guard let entityName = entity.name else { continue }
                let query = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: query)
                try viewContext.execute(deleteRequest)
            }
            try viewContext.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
}
