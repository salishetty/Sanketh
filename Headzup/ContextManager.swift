//
//  ContextManager.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/22/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

private var sharedContextManager: ContextManager!

class ContextManager {
    
    let managedContext: NSManagedObjectContext
    
    class var shared: ContextManager {
        return sharedContextManager
    }
    
    class func initialize(context: NSManagedObjectContext) {
        sharedContextManager = ContextManager(context: context)
    }
    
    private init(context: NSManagedObjectContext) {
        managedContext = context
    }
    
    func delete(entity: String, index: Int) -> Bool {
        var data = fetch(entity)
        do
        {
            if data != nil {
                managedContext.deleteObject(data![index])
                data!.removeAtIndex(index)
                try managedContext.save()
                return true
            }
        }
        catch
        {
            print("Save Failed")
        }
        return false
    }
    
    
    func fetch(entity: String) -> [NSManagedObject]? {
        do
        {
            let request = NSFetchRequest(entityName: entity)
            if let entities = try managedContext.executeFetchRequest(request) as? [NSManagedObject] {
                if entities.count > 0 {
                    return entities
                }
            }
        }
        catch
        {
            print("fetch failed")
        }
        return nil
    }
    
    func save(entity: String, _ attributes: [String: AnyObject]) -> NSManagedObject? {
        
        do
        {
            let entity = NSEntityDescription.entityForName(entity, inManagedObjectContext: managedContext)
            let object = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.managedContext)
            
            for (key, attr) in attributes {
                object.setValue(attr, forKey: key)
            }
            try managedContext.save()
            return object
        }
        catch
        {
            print("Error saving the object")
        }
        return nil
    }
}