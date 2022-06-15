//
//  StorageManager.swift
//  Cars
//
//  Created by Avaneesh on 05/04/22.
//

import Foundation
import CoreData
import UIKit


public enum modelKeys : String {
    case id = "id"
    case title = "title"
    case ingress = "ingress"
    case image = "image"
    case dateTime = "dateTime"
    case tags = "tags"
    case content = "content"
    case chnaged = "chnaged"
    case created = "created"
}

class CoreDataManager {
  
  static let sharedManager = CoreDataManager()
    
  // Prevent from creating another instance.
  private init() {}
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Cars")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
    /*Save*/
  func saveContext () {
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
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
  
  /*Insert*/
    func insertCar(car : Car) -> Void {
    
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "CarModel",
                                            in: managedContext)!
    let carMdl = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
  
        carMdl.setValue(car.id, forKeyPath: modelKeys.id.rawValue)
        carMdl.setValue(car.title, forKeyPath: modelKeys.title.rawValue)
        carMdl.setValue(car.ingress, forKeyPath: modelKeys.ingress.rawValue)
        carMdl.setValue(car.dateTime, forKeyPath: modelKeys.dateTime.rawValue)
        carMdl.setValue(car.tags, forKeyPath: modelKeys.tags.rawValue)
        carMdl.setValue(car.image, forKeyPath: modelKeys.image.rawValue)
        carMdl.setValue(car.content, forKeyPath: modelKeys.content.rawValue)
        carMdl.setValue(car.created, forKeyPath: modelKeys.created.rawValue)
        carMdl.setValue(car.changed, forKeyPath: modelKeys.chnaged.rawValue)

    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
  func fetchAllCars() -> [CarModel]?{
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CarModel")
    do {
      let Car = try managedContext.fetch(fetchRequest)
        return (Car as? [CarModel])!
    } catch let error as NSError {
        print("(Could not fetch. \(error), \(error.userInfo)")
       return []
    }
  }
}
