//
//  CoreDataLogic.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 14/3/24.

//



import UIKit
import CoreData


struct coreData{
    var title: String?
    var id: String?
    var details: String?
}

class CoreDataLogic {
    
    
    
    
    
    static func createData(ID: String, noteTitle: String , noteDetails: String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(ID, forKeyPath: "id")
        user.setValue(noteTitle, forKey: "title")
        user.setValue(noteDetails, forKey: "details")
        
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        do {
            try managedContext.save()
            print("Data Saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    
    static func retrieveData() -> [coreData] {
        
        
        var datalist: [coreData] = []

        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return datalist }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                
                var userdata = coreData()
                
                userdata.id = data.value(forKey: "id") as? String
                userdata.title = data.value(forKey: "title") as? String
                userdata.details = data.value(forKey: "details") as? String
                
                datalist.append(userdata)

            }
            
        } catch {
            
            print("Failed")
        }
        return datalist
        
    }
    
    static func updateData(){
        
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        //fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur1")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            for data in test as! [NSManagedObject] {
                
                if let item1 = data.value(forKey: "username") {
                    data.setValue("Ahmed", forKeyPath: "username")
                    
                }
                if let item2 = data.value(forKey: "email") {
                    data.setValue("abc@gmail.com", forKey: "email")
                }
                if let item3 = data.value(forKey: "password") {
                    data.setValue("654321", forKey: "password")
                }
            }
            
            do{
                try managedContext.save()
                print("Updated")
                
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
    static func deleteAllData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur3")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do
        {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
            print("Deleted")
        }catch
        {
            print(error)
        }
    }
    
    
    static func deleteDataOne(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur3")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            if test.count > 0 {
                //let objectToDelete = test[0] as! NSManagedObject
                let objectToDelete = test[test.count - 1] as! NSManagedObject
                managedContext.delete(objectToDelete)
                
            }
            
            do{
                try managedContext.save()
                print("Deleted")
                
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    
}



