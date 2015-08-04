//
//  DataManager.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/14/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class DataManager
{
    var dbContext: NSManagedObjectContext!
    //Set IV and Key
    let iv:[UInt8] = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
    let key:[UInt8] = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
    
    
    public init(objContext: NSManagedObjectContext) {
        self.dbContext = objContext
    }
    
    /// Meta Data
    public func saveMetaData(name: String, value: String, isSecured :Bool ){
        // check if given meta exists
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        fetchRequest.predicate = NSPredicate(format: "name == \"\(name)\"")
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [MetaData]
        
        var theMetaData:MetaData!
        if (fetchResults?.count>0){
            theMetaData = fetchResults?[0]
            println("found metadata \(theMetaData.toString())")
        } else {
            println("creating new metadata: \(name) : \(value)")
            theMetaData = NSEntityDescription.insertNewObjectForEntityForName("MetaData", inManagedObjectContext: dbContext) as! MetaData
        }
        
        theMetaData.name = name
        
        //if Security is enabled, encrypt the value
        if(isSecured == true && AppContext.enc)
        {
            //encrypt value
            let encryptedValue = CryptoUtility().getEncryptedData(value, iv: iv, key: key)
            
            theMetaData.value = encryptedValue
        }
        else
        {
            theMetaData.value = value
        }
        //theMetaData.value = value
        theMetaData.isSecured = isSecured
        
        dbContext.save(nil)
        println("meta saved: \(theMetaData.toString())")
    }
    
    // Return meta data string value. Empty string will be return if such meta data doesn't exist
    public func getMetaDataValue(name: String) -> String {
        
        var retVal = ""
        // check if given meta exists
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        fetchRequest.predicate = NSPredicate(format: "name == \"\(name)\"")
        
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [MetaData]
        
        var theMetaData:MetaData? = nil
        
        if (fetchResults?.count>0){
            theMetaData = fetchResults?[0]
            let m :MetaData! = fetchResults?[0]
            if(theMetaData?.isSecured == true && AppContext.enc)
            {
                //encrypt value
                var decryptedValue = CryptoUtility().getDecryptedData(theMetaData!.value, iv: iv, key: key)
                retVal = decryptedValue as String
                
            }
            else
            {
                retVal = theMetaData!.value
            }
            println("found metadata: \(name)->\(retVal)")
        } else {
            println("Cannot find matching MetaData for \(name)")
        }
        
        return retVal
    }
    
    public func getAllMetaData() -> [MetaData]?{
        // check if given meta exists
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [MetaData]
        
        var c: Int! = fetchResults?.count
        
        var s = "found \(c) metedata "
        var m:MetaData!
        
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            s += m.toString() + " "
        }
        println("\(s)")
        return fetchResults
    }
    
    public func deleteAllMetaData() {
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [MetaData]
        
        var c: Int! = fetchResults?.count
        var m:MetaData!
        
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            dbContext.deleteObject(m)
        }
        dbContext.save(nil)
    }
    
    public func deleteAllData(entity: String) {
        let fetchRequest = NSFetchRequest(entityName: entity)
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [NSManagedObject]
        
        var c: Int! = fetchResults?.count
        var m:NSManagedObject!
        
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            dbContext.deleteObject(m)
        }
        dbContext.save(nil)
}
    public func saveContent(contentID:Int, contentName:String, contentDescription:String, contentValue:String, contentType:String, imagePath:String, audioPath:String)
    {
        // check if given strategy exists
        let fetchRequest = NSFetchRequest(entityName: "Content")
        fetchRequest.predicate = NSPredicate(format: "contentID == \"\(contentID)\"")
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [Content]
        var theContent:Content!
        if (fetchResults?.count>0){
            theContent = fetchResults?[0]
            println("found \(theContent.contentName)")
        } else {
            println("creating new Content: \(contentID) : \(contentName)")
            theContent = NSEntityDescription.insertNewObjectForEntityForName("Content", inManagedObjectContext: dbContext) as! Content
        }
        theContent.contentID = contentID
        theContent.contentName = contentName
        theContent.contentValue = contentValue
        theContent.contentDescription = contentDescription
        //save data to coreData
        dbContext.save(nil)
        println("Content Saved: \(theContent.toString())")
    }
    
    public func getAllContents() -> [Content]?
    {
        let fetchRequest = NSFetchRequest(entityName: "Content")
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [Content]
        
        var c: Int! = fetchResults?.count
        
        var s = "found \(c) strategies: \n"
        var m:Content!
        
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            s += m.toString() + "\n"
        }
        println("\(s)")
        return fetchResults
    }
    public func getContentByID(contentID:Int)->Content?
    {
        var retVal = ""
        // check if given Content exists
        let fetchRequest = NSFetchRequest(entityName: "Content")
        fetchRequest.predicate = NSPredicate(format: "contentID == \"\(contentID)\"")
        
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [Content]
        
        var theContent:Content!
        
        if (fetchResults?.count>0)
        {
            theContent = fetchResults?[0]
            
            retVal = theContent.contentValue
            println("found Content: \(theContent?.contentName)->\(retVal)")
        }
        else
        {
            println("Cannot find matching Content for \(contentID)")
        }
        
        return theContent
        
    }

    public func getContentByIDs(contentIDs:String) ->[Content]?
    {
        let fetchRequest = NSFetchRequest(entityName: "Content")
        let contentIDsArray = contentIDs.componentsSeparatedByString(",")
        var theContentArray:[Content]?
        var contentID:String?
        for var i = 0; i < contentIDsArray.count; i++ {
            contentID = contentIDsArray[i]
            
            fetchRequest.predicate = NSPredicate(format: "contentID == \"\(contentID)\"")
            
            let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [Content]
            
            var theContent:Content!
            if (fetchResults?.count>0)
            {
                theContent = fetchResults?[0]
                
                theContentArray?.append(theContent)
                println("found Content: \(theContent?.contentName)")
            }
            else
            {
                println("Cannot find matching Content for \(contentID)")
            }

        }
        return theContentArray
    }
    public func saveContentCategory(categoryID:Int, categoryName:String, contentIDs:String)
    {
        // check if given strategy exists
        let fetchRequest = NSFetchRequest(entityName: "Category")
        fetchRequest.predicate = NSPredicate(format: "categoryID == \"\(categoryID)\"")
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [Category]
        var theCategory:Category!
        if (fetchResults?.count>0){
            theCategory = fetchResults?[0]
            println("found \(theCategory.categoryName)")
        } else {
            println("creating new Category: \(categoryID) : \(categoryName)")
            theCategory = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: dbContext) as! Category
        }
        theCategory.categoryID = categoryID
        theCategory.categoryName = categoryName
        theCategory.contentIDs = contentIDs
        
        //save data to coreData
        dbContext.save(nil)
        println("Category Saved: \(theCategory.toString())")
    }

}
