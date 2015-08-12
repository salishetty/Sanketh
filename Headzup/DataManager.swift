//
//  DataManager.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/14/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData
import UIKit

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
        var theContentArray = [Content]()
        
        var contentID:String?
        for var i = 0; i < contentIDsArray.count; i++ {
            contentID = contentIDsArray[i]
            
            let fomattedContentID = NSNumberFormatter().numberFromString(contentID!)
            var newContentID = fomattedContentID!.integerValue
            fetchRequest.predicate = NSPredicate(format: "contentID == \"\(newContentID)\"")
            
            let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [Content]
            
            var theContent:Content!
            if (fetchResults?.count>0)
            {
                theContent = fetchResults?[0]
                //Fill contentArray
                theContentArray.append(theContent)
                println("found Content: \(theContent?.contentName)")
            }
            else
            {
                println("Cannot find matching Content for \(contentID)")
            }

        }
        return theContentArray
    }
    public func getCategoryByID(categoryID:Int)->Category?
    {
        var retVal = ""
        // check if given Content exists
        let fetchRequest = NSFetchRequest(entityName: "Category")
        fetchRequest.predicate = NSPredicate(format: "categoryID == \"\(categoryID)\"")
        
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [Category]
        
        var theCategory:Category!
        
        if (fetchResults?.count>0)
        {
            theCategory = fetchResults?[0]
            
            retVal = theCategory.categoryName
            println("found Category with Category Name: \(theCategory?.categoryName)->\(retVal)")
        }
        else
        {
            println("Cannot find matching Content for \(categoryID)")
        }
        
        return theCategory
        
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
    public func getAllcategories() -> [Category]?
    {
        let fetchRequest = NSFetchRequest(entityName: "Category")
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [Category]
        
        var c: Int! = fetchResults?.count
        
        var s = "found \(c) Categories: \n"
        var m:Category!
        
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            s += m.toString() + "\n"
        }
        println("\(s)")
        return fetchResults
    }
    //Methods for UserAction Entity
    
    public func saveUserActionLog(actionType:String, actionDateTime:NSDate,contentID:String, comment:String, isSynched:Bool)
    {
        var theData = NSEntityDescription.insertNewObjectForEntityForName("UserActionLog", inManagedObjectContext: dbContext) as! UserActionLog
        theData.osVersion = UIDevice.currentDevice().systemVersion
        theData.appVersion = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! String
        theData.actionType = actionType
        theData.actionDateTime = actionDateTime
        theData.contentID = contentID
        theData.comment = comment
        theData.isSynched = isSynched
        //save to coredata
        dbContext.save(nil)
        println("UserActionLog saved)")
    }
    
    public func getUserActionLogs(max: Int) -> [UserActionLog]? {
        
        let fetchRequest = NSFetchRequest(entityName: "UserActionLog")
        let oldOID = getMetaDataValue("UserActionID").toInt()
        
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [UserActionLog]
        
        var c: Int! = fetchResults?.count
        
        var s = "found \(c) user action logs: \n"
        var m:UserActionLog!
        
        var r = [UserActionLog]()
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            var lastComponent = fetchResults?[i].objectID.URIRepresentation().absoluteString?.lastPathComponent
            //get the integer component of objectID
            let currentOID = lastComponent?.substringFromIndex(advance(lastComponent!.startIndex, 1)).toInt()
            println("ObjectID:\(lastComponent?.substringFromIndex(advance(lastComponent!.startIndex, 1)))")
            if(currentOID > oldOID)
            {
                r.append(m)
            }
            s += m.toString() + "\n"
        }
        println("\(s)")
        
        return r
    }

    public func saveTechnicalLog(message:String, exception:String, moduleName:String, eventDate:String, appVersion:String, osversion:String, logLevel:String, isSynched:Bool)
    {
        var theTechLogData = NSEntityDescription.insertNewObjectForEntityForName("TechnicalLog", inManagedObjectContext: dbContext) as! TechnicalLog
        theTechLogData.message = message
        theTechLogData.exception = exception
        theTechLogData.moduleName = moduleName
        theTechLogData.eventDate = eventDate
        theTechLogData.osVersion = UIDevice.currentDevice().systemVersion
        theTechLogData.appVersion = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! String
        theTechLogData.logLevel = logLevel
        
        
        
        theTechLogData.isSynched = isSynched
        //save to coredata
        dbContext.save(nil)
        println("TechnicalLog saved)")
    }
    public func getTechnicalLogs(max:Int)-> [TechnicalLog]?
    {
        let fetchRequest = NSFetchRequest(entityName: "TechnicalLog")
        //let oldOID = NSUserDefaults.standardUserDefaults().stringForKey("ObjectID")
        let oldOID = getMetaDataValue("TechnicalLogID").toInt()
        
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [TechnicalLog]
        
        var c: Int! = fetchResults?.count
        
        var s = "found \(c) technical Logs: \n"
        var m:TechnicalLog!
        
        var r = [TechnicalLog]()
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            var lastComponent = fetchResults?[i].objectID.URIRepresentation().absoluteString?.lastPathComponent
            //get the integer component of objectID
            let currentOID = lastComponent?.substringFromIndex(advance(lastComponent!.startIndex, 1)).toInt()
            println("ObjectID:\(lastComponent?.substringFromIndex(advance(lastComponent!.startIndex, 1)))")
            if(currentOID > oldOID)
            {
                r.append(m)
            }
            s += m.toString() + "\n"
        }
        println("\(s)")
        
        return r
        
    }
    public func deleteTechnicalLog(technicalLog:TechnicalLog)
    {
        //Delete TechnicalLog object from CoreData
        dbContext.deleteObject(technicalLog)
    }

    public func saveContentGroup(groupType:NSNumber, dateModified:NSDate, contentID:NSNumber, isActive:Bool)
    {
        // check if given ContentGroup exists
        let fetchRequest = NSFetchRequest(entityName: "ContentGroup")
        fetchRequest.predicate = NSPredicate(format: "contentID == \"\(contentID)\"")
        
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [ContentGroup]
        
        var theContentGroup:ContentGroup!
        if (fetchResults?.count>0){
            theContentGroup = fetchResults?[0]
            println("Found ContentGroup with ContentID: \(theContentGroup.contentID)")
        } else {
            println("Creating new ContentGroup: \(contentID)")
            theContentGroup = NSEntityDescription.insertNewObjectForEntityForName("ContentGroup", inManagedObjectContext: dbContext) as! ContentGroup
        }
        theContentGroup.groupType = groupType
        theContentGroup.contentID = contentID
        theContentGroup.isActive = isActive
        theContentGroup.dateModified = dateModified
        //save to coredata
        dbContext.save(nil)
        println("ContentGroup saved)")
    }
    public func deleteContentGroup(contentID:NSNumber)
    {
        var contentGroup:NSManagedObject = getContentGroup(contentID)!
        //Delete from contentGroup object
        dbContext.deleteObject(contentGroup)
    }
    public func getContentGroup(contentID:NSNumber)->ContentGroup?
    {
        
        // check if given meta exists
        let fetchRequest = NSFetchRequest(entityName: "ContentGroup")
        fetchRequest.predicate = NSPredicate(format: "contentID == \"\(contentID)\"")
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [ContentGroup]
        
        var theContentGroup:ContentGroup!
        if (fetchResults?.count>0){
            theContentGroup = fetchResults?[0]
            println("Found ContentGroup with ContentID: \(theContentGroup.contentID)")
        } else {
            println("No ContentGroup Found with a matching record for ContentID:\(contentID)")
        }
        
        return theContentGroup
    }
    public func getContentGroups(max: Int) -> [ContentGroup]? {
        var gHelpers = GeneralHelper()
        let fetchRequest = NSFetchRequest(entityName: "ContentGroup")
        
        let synchDate = getMetaDataValue("SynchDate")
        
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [ContentGroup]
        
        var c: Int! = fetchResults?.count
        
        var s = "found \(c) user action logs: \n"
        var m:ContentGroup!
        
        var r = [ContentGroup]()
        if synchDate != ""
        {
            for var i = 0; i < c; i++ {
                m = fetchResults?[i]
                //Do comparison using extension methods
                if m.dateModified.isGreaterThanDate(gHelpers.convertStringToDate(synchDate))
                {
                    r.append(m)
                }
                s += m.toString() + "\n"
            }
        }
        else
        {
            r = fetchResults!
        }
        println("\(s)")
        
        return r
    }

}
