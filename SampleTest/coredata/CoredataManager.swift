//
//  CoredataManager.swift
//  SampleTest
//
//  Created by Kamalesh Kumar Yadav on 02/03/19.
//  Copyright © 2019 Kamlesh Kumar. All rights reserved.
//

import UIKit
import CoreData
class CoredataManager: NSObject {
    static let shared = CoredataManager()
    private override init() {}
    
//    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Inventory.self))
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "travelsName", ascending: true)]
//        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//       // frc.delegate = self
//        return frc
//
//    }()

    
    
    // MARK: - Core Data stack
    
     var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SampleTest")
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    func clearData() {
        do {
            
            let context = self.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Inventory.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                self.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    func createInventryEntityFrom(imgBaseUrl:String,dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = self.persistentContainer.viewContext
        if let inventryEntity = NSEntityDescription.insertNewObject(forEntityName: "Inventory", into: context) as? Inventory {
            
            if let source = dictionary["src"] as? String {
                inventryEntity.source = source
            }else {
                inventryEntity.source = ""
            }
            
            if let destination = dictionary["dst"] as? String {
                inventryEntity.destination = destination
            }else {
                inventryEntity.destination = ""
            }
            
            if let deptTime = dictionary["dt"] as? String {
                inventryEntity.deptTime = deptTime.toDate(withFormat: "dd/MM/yyyy HH:mm:ss a")
            }else {
                inventryEntity.deptTime = nil
            }
            
            if let arivalTime = dictionary["at"] as? String {
                inventryEntity.arivalTime = arivalTime
            }else {
                inventryEntity.arivalTime = ""
            }
            
            if let travelsName = dictionary["Tvs"] as? String {
                inventryEntity.travelsName = travelsName
            }else {
                inventryEntity.travelsName = ""
            }
            
            if let ratedict = dictionary["rt"] as? [String:Any]{
            if let rating = ratedict["totRt"] as? Double {
                inventryEntity.rating = Int16(rating)
            }else {
                inventryEntity.rating = Int16(0)
                }}
            else{
                inventryEntity.rating = Int16(0)
            }
            
            if let imageUrl = dictionary["lp"] as? String {
                inventryEntity.imageUrl = imgBaseUrl + imageUrl
            }else {
                inventryEntity.imageUrl = ""
            }
            
            if let busFair = dictionary["minfr"] as? Double {
                inventryEntity.busFair = busFair
            }else {
                inventryEntity.busFair = 0.0
            }
            
            if let currency = dictionary["cur"] as? String {
                inventryEntity.currency = currency
            }else {
                inventryEntity.currency = ""
            }
            
            
            if let typeBus =  dictionary["Bc"] as? [String:Bool]{
                if let value = typeBus["IsAc"]{
                    inventryEntity.busTypeAc = value
                }
                if let value = typeBus["IsNonAc"] {
                    inventryEntity.busTypeNonAc = value
                }
                if let value = typeBus["IsSeater"]{
                    inventryEntity.busTypeSeat = value
                }
                if let value = typeBus["IsSleeper"]{
                    inventryEntity.bustypeSl = value
                }
            }
            
            return inventryEntity
        }
        return nil
    }
    
    func saveInCoreDataWith(imgBaseUrl:String,array: [[String: AnyObject]]) {
        _ = array.map{self.createInventryEntityFrom(imgBaseUrl: imgBaseUrl, dictionary: $0)}
        do {
            try self.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func fetchRecored(entityName:String,filterBy:NSPredicate?, soretBy:[NSSortDescriptor]?) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
      
        request.predicate = filterBy
        request.sortDescriptors = soretBy
        request.returnsObjectsAsFaults = false
        do {
            let result = try self.persistentContainer.viewContext.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "source") as! String)
            }
            return result as! [NSManagedObject]
        } catch {
            
            print("Failed")
        }
        return []
    }

    
}
