//
//  HelperCoreData.swift
//  TestDogsMobile
//
//  Created by Jose Luis on 16/03/22.
//

import Foundation
import UIKit
import CoreData

final class HelperCoreData: NSObject {
    func saveDog(withDog:Dog){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let idString = UUID().uuidString
        let userEntity = NSEntityDescription.entity(forEntityName: "Dogs", in: managedContext)!
        let dog = NSManagedObject(entity: userEntity, insertInto: managedContext)
        dog.setValue(idString.split(separator: "-").last, forKeyPath: "id")
        dog.setValue(withDog.dogName, forKeyPath: "name")
        dog.setValue(withDog.strDescription, forKey: "details")
        dog.setValue(withDog.dogImage, forKey: "url_icon")
        dog.setValue(withDog.age, forKey: "age")
        do {
            try managedContext.save()
            print("Success Saved Dog")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func deleteAllDogs(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dogs")
        let managedContext = appDelegate.persistentContainer.viewContext
           fetchRequest.returnsObjectsAsFaults = false
           do {
               let results = try managedContext.fetch(fetchRequest)
               for object in results {
                   guard let objectData = object as? NSManagedObject else {continue}
                   managedContext.delete(objectData)
               }
               print("Detele all data success!!")
           } catch let error {
               print("Detele all data in \(fetchRequest.entityName) error :", error)
           }
    }
    func gatAllDogs() -> [Dog] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dogs")
        do {
            let result = try managedContext.fetch(fetchRequest)
            var allDogs:[Dog] = []
            for data in result as! [NSManagedObject] {
                var dog = Dog()
                if let id = data.value(forKey: "id") as? String {
                    dog.id = id
                }
                if let name = data.value(forKey: "name") as? String {
                    dog.dogName = name
                }
                if let desctip = data.value(forKey: "details") as? String {
                    dog.strDescription = desctip
                }
                if let age = data.value(forKey: "details") as? Int {
                    dog.age = age
                }
                if let image = data.value(forKey: "url_icon") as? String {
                    dog.dogImage = image
                }
                allDogs.append(dog ?? Dog())
            }
            return allDogs
        } catch {
            print("Failed")
            return []
        }
    }
       
    func updateDog(dog:Dog) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  false}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Dogs")
        fetchRequest.predicate = NSPredicate(format: "id = %@", dog.id ?? "")
        do {
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(dog.id, forKey: "id")
            objectUpdate.setValue(dog.dogName, forKey: "name")
            objectUpdate.setValue(dog.strDescription, forKey: "details")
            objectUpdate.setValue(dog.dogImage, forKey: "url_icon")
            do{
                try managedContext.save()
                return true
            }catch{
                print(error)
                return false
            }
        }catch{
            print(error)
            return false
        }
    }
       
    func deleteData(byId:String) -> Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dogs")
        fetchRequest.predicate = NSPredicate(format: "id = %@", byId)
        do  {
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do{
                try managedContext.save()
                return true
            }catch {
                print(error)
                return false
            }
        }catch{
            print(error)
            return false
        }
    }
}
