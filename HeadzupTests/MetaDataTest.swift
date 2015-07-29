//
//  MetaDataTest.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/28/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit

import XCTest

import CoreData



class MetaDataTestCase: CoreDataTestCase {
    
    
    var metaData:MetaData?
    
    override func setUp() {
        
        super.setUp()
        
    }
    
    
    
    func saveMetaData(name: String, value: String, isSecured :Bool ){
        
        // check if given meta exists
        
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        
        fetchRequest.predicate = NSPredicate(format: "name == \"\(name)\"")
        
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [MetaData]
        
        var theMetaData:MetaData!
        
        if (fetchResults?.count>0){
            
            // newMetaData
            
            println("metadata exists before saving: \(fetchResults?[0])")
            
            theMetaData = fetchResults?[0]
            
        } else {
            
            
            //theMetaData = NSEntityDescription.insertNewObjectForEntityForName("MetaData", inManagedObjectContext: dbContext) as! MetaData
            
            //let entity = NSEntityDescription.entityForName("MetaData", inManagedObjectContext: managedObjectContext!)
            
            //var myMetaData = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext!) as? MetaData
            
            let entity = NSEntityDescription.entityForName("MetaData", inManagedObjectContext: managedObjectContext!)
            
            let myMetaData = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext!)
            
            myMetaData.setValue(name, forKey: "name")
            
            myMetaData.setValue(value, forKey: "value")
            
            myMetaData.setValue(isSecured, forKey: "isSecured")
            
            
            
            var error: NSError?
            
            if !managedObjectContext!.save(&error){
                
                println("Could not save \(error), \(error?.userInfo)")
                
            }
            
        }
        
        
        
    }
    
    
    func testThatWeCanCreateMetaData() {
        
        //TO DO: Uncomment the implementation in this method to run the the unit test - AW - 05/19/2015
        
        //var dm = DataManager(objContext: managedObjectContext!)
        
        //dm.saveMetaData("PhoneNumber", value: "123", isSecured: false)
        //saveMetaData("PhoneNumber", value: "123", isSecured: false)
        
        //XCTAssertNotNil(self.metaData, "unable to create a metadata")
        
    }
    
    
    func testThatWeCanGetMetaData() {
        
        //TO DO: Uncomment the implementation in this method to run the the unit test - AW - 05/19/2015
        
        //var dm = DataManager(objContext: managedObjectContext!)
        
        //metaData = dm.getMetaData("PhoneNumber")
        
        //XCTAssertNotNil(metaData, "unable to get metadata")
        
    }
    
    
    
}

