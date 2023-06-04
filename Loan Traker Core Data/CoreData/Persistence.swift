//
//  Persistence.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 3.06.2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Loan_Traker_Core_Data")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            debugPrint("😡 Error saving to CD, \(error.localizedDescription)")
        }
    }
}
