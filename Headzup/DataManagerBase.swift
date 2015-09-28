//
//  DataManagerBase.swift
//  Headzup
//
//  Created by Abebe Woreta on 9/27/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class DataManagerBase
{
    var managedContext: NSManagedObjectContext!
    public init(context: NSManagedObjectContext) {
        self.managedContext = context
    }
    public func fetchEntity(entityName: String) -> [NSManagedObject]? {
        do
        {
            let fetchRequest = NSFetchRequest(entityName: entityName)
            if let fetchResult = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
                if fetchResult.count > 0 {
                    return fetchResult
                }
            }
        }
        catch let error as NSError
        {
            print("Error fetching entity: \(entityName) : \(error.localizedDescription) ")
        }
        return nil
    }

    public func fetchEntity(entityName: String, key:String, value:String) -> [NSManagedObject]? {
        do
        {
            let fetchRequest = NSFetchRequest(entityName: entityName)
            fetchRequest.predicate = NSPredicate(format: "\(key) == \"\(value)\"")
            if let fetchResult = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
                if fetchResult.count > 0 {
                    return fetchResult
                }
            }

        }
        catch let error as NSError
        {
            print("Error fetching entity: \(entityName) : \(error.localizedDescription) ")
        }
        return nil
    }

    public func saveEntity(entityName: String, properties: [String: AnyObject]) -> NSManagedObject? {
        do
        {
            let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedContext)
            let managedObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.managedContext)
            for (key, val) in properties {
                managedObject.setValue(val, forKey: key)
            }
            try managedContext.save()
            return managedObject
        }
        catch let error as NSError
        {
            print("Error Saving entity: \(entityName) : \(error.localizedDescription) ")
        }
        return nil
    }

}
