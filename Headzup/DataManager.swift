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

public class DataManager:DataManagerBase
{
    var dbContext: NSManagedObjectContext!
    //Set IV and Key
    let iv:[UInt8] = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
    let key:[UInt8] = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
    
    
    public init(objContext: NSManagedObjectContext) {
        self.dbContext = objContext
        super.init(context: self.dbContext!)
    }
    
    
    /// Meta Data
    public func saveMetaData(name: String, value: String, isSecured :Bool )
    {
        var theProperties: [String: AnyObject] = [:]
        var theMetaData:MetaData!
        if let fetchResults = super.fetchEntity("MetaData", key: "name", value: name)
        {
            var metaData:[MetaData] = fetchResults as! [MetaData]
            theMetaData = metaData[0]
            print("found metadata \(theMetaData.toString())")
        }
        else {
            print("creating new metadata: \(name) : \(value)")
            theProperties["name"] = name
            if(isSecured == true && AppContext.enc)
            {
                //encrypt value
                let encryptedValue = CryptoUtility().getEncryptedData(value, iv: iv, key: key)
                theProperties["value"] = encryptedValue
            }
            else
            {
                theProperties["value"] = value
            }
            theProperties["isSecured"] = isSecured
            theMetaData = super.saveEntity("MetaData", properties: theProperties) as! MetaData
        }
        print("meta saved: \(theMetaData.toString())")
    }
    
    // Return meta data string value. Empty string will be return if such meta data doesn't exist
    public func getMetaDataValue(name: String) -> String {
        
        var retVal = ""
        do{
            // check if given meta exists
            let fetchRequest = NSFetchRequest(entityName: "MetaData")
            fetchRequest.predicate = NSPredicate(format: "name == \"\(name)\"")
            
            let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as! [MetaData]
            
            //var theMetaData:MetaData? = nil
            
            if (fetchResults.count>0){
                
                let theMetaData :MetaData! = fetchResults[0]
                if(theMetaData?.isSecured == true && AppContext.enc)
                {
                    //encrypt value
                    let decryptedValue = CryptoUtility().getDecryptedData(theMetaData!.value, iv: iv, key: key)
                    retVal = decryptedValue as String
                    
                }
                else
                {
                    retVal = theMetaData!.value
                }
                print("found metadata: \(name)->\(retVal)")
            } else {
                print("Cannot find matching MetaData for \(name)")
            }
            
        }
        catch let error as NSError
        {
            print("Error fetching Metadata Value: \(error.localizedDescription)")
        }
        return retVal
        
    }
    
    public func getAllMetaData() -> [MetaData]?{
        do
        {
            // check if given meta exists
            let fetchRequest = NSFetchRequest(entityName: "MetaData")
            
            let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as! [MetaData]
            
            let c: Int! = fetchResults.count
            
            var s = "found \(c) metedata "
            var m:MetaData!
            
            for var i = 0; i < c; i++ {
                m = fetchResults[i]
                s += m.toString() + " "
            }
            print("\(s)")
            return fetchResults
        }
        catch let error as NSError
        {
            print("Error fetching all Metadata: \(error.localizedDescription)")
        }
        return nil
    }
    
    public func deleteAllMetaData() {
        do
        {
            let fetchRequest = NSFetchRequest(entityName: "MetaData")
            let fetchResults =  try dbContext!.executeFetchRequest(fetchRequest) as! [MetaData]
            
            let c: Int! = fetchResults.count
            var m:MetaData!
            
            for var i = 0; i < c; i++ {
                m = fetchResults[i]
                dbContext.deleteObject(m)
            }
            try dbContext.save()
        }
        catch let error as NSError
        {
            print("Failed deleting all Metadata: \(error.localizedDescription)")
        }
    }
    
    public func deleteAllData(entity: String) {
        do
        {
            let fetchRequest = NSFetchRequest(entityName: entity)
            let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            
            let c: Int! = fetchResults.count
            var m:NSManagedObject!
            
            for var i = 0; i < c; i++ {
                m = fetchResults[i]
                dbContext.deleteObject(m)
            }
            try dbContext.save()
        }
        catch let error as NSError
        {
            print("Failed deleting entity :\(entity) with error: \(error.localizedDescription)")
        }
    }
    
    public func saveContent(contentID:NSNumber, contentName:String, contentDescription:String, contentValue:String, contentType:String, imagePath:String, audioPath:String)
    {
        var theProperties: [String: AnyObject] = [:]
        var theContent:Content!
        if let fetchResults = super.fetchEntity("Content", key: "contentID", value: contentID.stringValue)
        {
            var content:[Content] = fetchResults as! [Content]
            theContent = content[0]
            print("found Content \(theContent.toString())")
        }
        else {
            print("creating new Content: \(contentID) : \(contentName)")
            theProperties["contentID"] = contentID
            theProperties["contentName"] = contentName
            theProperties["contentValue"] = contentValue
            theProperties["contentDescription"] = contentDescription
            theProperties["imagePath"] = imagePath
            theProperties["audioPath"] = audioPath
            theContent = super.saveEntity("Content", properties: theProperties) as! Content
        }
        print("Content Saved: \(theContent.toString())")
    }
    
    public func getAllContents() -> [Content]?
    {
        
        do
        {
            let fetchRequest = NSFetchRequest(entityName: "Content")
            let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as! [Content]
            
            let c: Int! = fetchResults.count
            
            var s = "found \(c) strategies: \n"
            var m:Content!
            
            for var i = 0; i < c; i++ {
                m = fetchResults[i]
                s += m.toString() + "\n"
            }
            print("\(s)")
            return fetchResults
        }
        catch let error as NSError
        {
            print("Error fetching all Contents: \(error.localizedDescription)")
        }
        return nil
    }
    public func getContentByID(contentID:Int)->Content?
    {
        do{
            var retVal = ""
            // check if given Content exists
            let fetchRequest = NSFetchRequest(entityName: "Content")
            fetchRequest.predicate = NSPredicate(format: "contentID == \"\(contentID)\"")
            
            let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as? [Content]
            
            var theContent:Content!
            
            if (fetchResults?.count>0)
            {
                theContent = fetchResults?[0]
                
                retVal = theContent.contentValue
                print("found Content: \(theContent?.contentName)->\(retVal)")
            }
            else
            {
                print("Cannot find matching Content for \(contentID)")
            }
            
            return theContent
        }
        catch let error as NSError
        {
            print("Error getting content by ContentID: \(error.localizedDescription)")
        }
        return nil
    }
    
    public func getContentByIDs(contentIDs:String) ->[Content]?
    {
        do
        {
            let fetchRequest = NSFetchRequest(entityName: "Content")
            let contentIDsArray = contentIDs.componentsSeparatedByString(",")
            var theContentArray = [Content]()
            
            var contentID:String?
            for var i = 0; i < contentIDsArray.count; i++ {
                contentID = contentIDsArray[i]
                
                let fomattedContentID = NSNumberFormatter().numberFromString(contentID!)
                let newContentID = fomattedContentID!.integerValue
                fetchRequest.predicate = NSPredicate(format: "contentID == \"\(newContentID)\"")
                
                let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as? [Content]
                
                var theContent:Content!
                if (fetchResults?.count>0)
                {
                    theContent = fetchResults?[0]
                    //Fill contentArray
                    theContentArray.append(theContent)
                    print("found Content: \(theContent?.contentName)")
                }
                else
                {
                    print("Cannot find matching Content for \(contentID)")
                }
                
            }
            return theContentArray
        }
        catch let error as NSError
        {
            print("Error returning Content by ContentIDS: \(error.localizedDescription)")
        }
        return nil
    }
    
    public func getCategoryByID(categoryID:Int)->Category?
    {
        do
        {
            var retVal = ""
            // check if given Content exists
            let fetchRequest = NSFetchRequest(entityName: "Category")
            fetchRequest.predicate = NSPredicate(format: "categoryID == \"\(categoryID)\"")
            
            let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as? [Category]
            
            var theCategory:Category!
            
            if (fetchResults?.count>0)
            {
                theCategory = fetchResults?[0]
                
                retVal = theCategory.categoryName
                print("found Category with Category Name: \(theCategory?.categoryName)->\(retVal)")
            }
            else
            {
                print("Cannot find matching Content for \(categoryID)")
            }
            return theCategory
        }
        catch let error as NSError
        {
            print("Error getting Category by ID : \(error.localizedDescription)")
        }
        return nil
     }
    
    public func saveContentCategory(categoryID:Int, categoryName:String, contentIDs:String)
    {
        var theProperties: [String: AnyObject] = [:]
        var theCategory:Category!
        if let fetchResults = super.fetchEntity("Category", key: "categoryID", value: String(categoryID))
        {
            var category:[Category] = fetchResults as! [Category]
            theCategory = category[0]
            print("found Category \(theCategory.toString())")
        }
        else
        {
            print("creating new Category: \(categoryID) : \(categoryName)")
            theProperties["categoryID"] = categoryID
            theProperties["categoryName"] = categoryName
            theProperties["contentIDs"] = contentIDs
            theCategory = super.saveEntity("Category", properties: theProperties) as! Category
        }
        theCategory.categoryID = categoryID
        theCategory.categoryName = categoryName
        theCategory.contentIDs = contentIDs
        print("Category Saved: \(theCategory.toString())")
    }
public func getAllcategories() -> [Category]?
{
    do
    {
        let fetchRequest = NSFetchRequest(entityName: "Category")
        let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as? [Category]
        
        let c: Int! = fetchResults?.count
        
        var s = "found \(c) Categories: \n"
        var m:Category!
        
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            s += m.toString() + "\n"
        }
        print("\(s)")
        return fetchResults
    }
    catch let error as NSError
    {
        print("Failed to fetch all Categories: \(error.localizedDescription)")
    }
    return nil
}
//Methods for UserAction Entity

public func saveUserActionLog(actionType:String, actionDateTime:NSDate,contentID:String, comment:String, isSynched:Bool)
{
    do
    {
        let theData = NSEntityDescription.insertNewObjectForEntityForName("UserActionLog", inManagedObjectContext: dbContext) as! UserActionLog
        theData.osVersion = UIDevice.currentDevice().systemVersion
        theData.appVersion = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! String
        theData.actionType = actionType
        theData.actionDateTime = actionDateTime
        theData.contentID = contentID
        theData.comment = comment
        theData.isSynched = isSynched
        //save to coredata
        try dbContext.save()
        print("UserActionLog saved)")
    }
    catch let error as NSError
    {
        print("Error saving to UserActionLog: \(error.localizedDescription)")
    }
}

public func getUserActionLogs(max: Int) -> [UserActionLog]? {
    
    do
    {
        let fetchRequest = NSFetchRequest(entityName: "UserActionLog")
        
        let oldOID = Int(getMetaDataValue("UserActionID"))
        
        let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as? [UserActionLog]
        
        let c: Int! = fetchResults?.count
        
        var s = "found \(c) user action logs: \n"
        var m:UserActionLog!
        
        var r = [UserActionLog]()
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            let lastComponent = fetchResults?[i].objectID.URIRepresentation().absoluteString.lastPathComponent
            //get the integer component of objectID
            let currentOID = Int(lastComponent!.substringFromIndex(lastComponent!.startIndex.advancedBy(1)))
            print("ObjectID:\(lastComponent?.substringFromIndex(lastComponent!.startIndex.advancedBy(1)))")
            if(currentOID > oldOID)
            {
                r.append(m)
            }
            s += m.toString() + "\n"
        }
        print("\(s)")
        
        return r
    }
    catch let error as NSError
    {
        print("Failed to fetch UserActionLogs: \(error.localizedDescription)")
    }
    return nil
}

public func saveTechnicalLog(message:String, exception:String, moduleName:String, eventDate:String, appVersion:String, osversion:String, logLevel:String, isSynched:Bool)
{
    do
    {
    
        let theTechLogData = NSEntityDescription.insertNewObjectForEntityForName("TechnicalLog", inManagedObjectContext: dbContext) as! TechnicalLog
        theTechLogData.message = message
        theTechLogData.exception = exception
        theTechLogData.moduleName = moduleName
        theTechLogData.eventDate = eventDate
        theTechLogData.osVersion = UIDevice.currentDevice().systemVersion
        theTechLogData.appVersion = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! String
        theTechLogData.logLevel = logLevel
        theTechLogData.isSynched = isSynched
        //save to coredata
        try dbContext.save()
        print("TechnicalLog saved)")
            
    }
    catch let error as NSError
    {
        print("Error saving to TechnicalLog: \(error.localizedDescription)")
    }
}
public func getTechnicalLogs(max:Int)-> [TechnicalLog]?
{
    do
    {
        
        let fetchRequest = NSFetchRequest(entityName: "TechnicalLog")
        //let oldOID = NSUserDefaults.standardUserDefaults().stringForKey("ObjectID")
        let oldOID = Int(getMetaDataValue("TechnicalLogID"))
        
        let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as? [TechnicalLog]
        
        let c: Int! = fetchResults?.count
        
        var s = "found \(c) technical Logs: \n"
        var m:TechnicalLog!
        
        var r = [TechnicalLog]()
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            let lastComponent = fetchResults?[i].objectID.URIRepresentation().absoluteString.lastPathComponent
            //get the integer component of objectID
            let currentOID = Int(lastComponent!.substringFromIndex(lastComponent!.startIndex.advancedBy(1)))
            print("ObjectID:\(lastComponent?.substringFromIndex(lastComponent!.startIndex.advancedBy(1)))")
            if(currentOID > oldOID)
            {
                r.append(m)
            }
            s += m.toString() + "\n"
        }
        print("\(s)")
        
        return r

    }
    catch let error as NSError
    {
        print("Error saving to TechnicalLog: \(error.localizedDescription)")
    }
    return nil
}
public func deleteTechnicalLog(technicalLog:TechnicalLog)
{
    //Delete TechnicalLog object from CoreData
    dbContext.deleteObject(technicalLog)
}
public func deleteUserActionLogs(userActionLog:UserActionLog)
{
    //Delete UserActionLog object from CoreData
    dbContext.deleteObject(userActionLog)
}

public func saveContentGroup(groupType:NSNumber, dateModified:NSDate, contentID:NSNumber, isActive:Bool)
{
    do
    {
        // check if given ContentGroup exists
        let fetchRequest = NSFetchRequest(entityName: "ContentGroup")
        fetchRequest.predicate = NSPredicate(format: "contentID == \"\(contentID)\" AND groupType == \"\(groupType)\"")
        
        var fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as? [ContentGroup]
        
        var theContentGroup:ContentGroup!
        if (fetchResults?.count>0){
            theContentGroup = fetchResults?[0]
            print("Found ContentGroup with ContentID: \(theContentGroup.contentID)")
        } else {
            print("Creating new ContentGroup: \(contentID)")
            theContentGroup = NSEntityDescription.insertNewObjectForEntityForName("ContentGroup", inManagedObjectContext: dbContext) as! ContentGroup
            
        }
        theContentGroup.groupType = groupType
        theContentGroup.contentID = contentID
        theContentGroup.isActive = isActive
        theContentGroup.dateModified = dateModified
        //save to coredata
        try dbContext.save()
        print("ContentGroup saved)")

    }
    catch let error as NSError
    {
        print("Error saving to ContentGroup: \(error.localizedDescription)")
    }
}
public func deleteContentGroup(contentID:NSNumber)
{
    let contentGroup:NSManagedObject = getContentGroup(contentID)!
    //Delete from contentGroup object
    dbContext.deleteObject(contentGroup)
}
public func getContentGroup(contentID:NSNumber)->ContentGroup?
{
    var theContentGroup:ContentGroup!
    if let fetchResults = super.fetchEntity("ContentGroup", key: "contentID", value: String(contentID))
    {
        var contentGroup:[ContentGroup] = fetchResults as! [ContentGroup]
        theContentGroup = contentGroup[0]
        print("Found ContentGroup with ContentID: \(theContentGroup.contentID)")
    }
    else
    {
        print("No ContentGroup Found with a matching record for ContentID:\(contentID)")
    }
    return theContentGroup
}
public func getFavoritedContent(contentID:NSNumber)->ContentGroup?
{
    do
    {
        // check if given meta exists
        let fetchRequest = NSFetchRequest(entityName: "ContentGroup")
        fetchRequest.predicate = NSPredicate(format: "isActive == 1 AND contentID == \"\(contentID)\"")
        let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as? [ContentGroup]
        
        var theContentGroup:ContentGroup!
        if (fetchResults?.count>0){
            theContentGroup = fetchResults?[0]
            print("Found ContentGroup with ContentID: \(theContentGroup.contentID)")
        } else {
            print("No ContentGroup Found with a matching record for ContentID:\(contentID)")
        }
        
        return theContentGroup
    }
    catch let error as NSError
    {
        print("Fetch failed for ContentGroup: \(error.localizedDescription)")
    }
    return nil
}
public func getContentGroups(max: Int) -> [ContentGroup]?
{
    let synchDate = getMetaDataValue("SynchDate")
    var contentGroup = [ContentGroup]()
    var theContentGroup:ContentGroup!
    if let fetchResults = super.fetchEntity("ContentGroup")
    {
        let c: Int! = fetchResults.count
        contentGroup = fetchResults as! [ContentGroup]
        var s = "found \(c) content groups: \n"
        if synchDate != ""
        {
            for var i = 0; i < c; i++ {
                theContentGroup = fetchResults[i] as! ContentGroup
                //Do comparison using extension methods
                if theContentGroup.dateModified.isGreaterThanDate(GeneralHelper.convertStringToDate(synchDate))
                {
                    contentGroup.append(theContentGroup)
                }
                s += theContentGroup.toString() + "\n"
            }
        }
        else
        {
            contentGroup = fetchResults as! [ContentGroup]
        }
        print("\(s)")
    }
    else
    {
        print("No ContentGroup found")
    }
    return contentGroup
}
//Returns FirstAid Contents
public func getFirstAidContents() -> [Int]
{
    let contentGroup:[ContentGroup] = getContentGroups(0)!
    var contentIds = [Int]()
    
    for conGroup in contentGroup
    {
        if conGroup.groupType.stringValue == GroupType.OMG
        {
            contentIds.append(conGroup.contentID.integerValue)
        }
    }
    return contentIds
}

public func getFavoritedContents() -> [ContentGroup]?
{
    var contentGroup = [ContentGroup]()
    var theContentGroup:ContentGroup!
    if let fetchResults = super.fetchEntity("ContentGroup")
    {
        let c: Int! = fetchResults.count
        print("found \(c) content groups: \n")
        for var i = 0; i < c; i++ {
            theContentGroup = fetchResults[i] as! ContentGroup
            print("isActive: \(theContentGroup.isActive) => GroupType: \(theContentGroup.groupType.stringValue) => Favorite: \(GroupType.Favorite)")
            if (theContentGroup.isActive.stringValue == "1" && (theContentGroup.groupType.stringValue == GroupType.Favorite))
            {
                contentGroup.append(theContentGroup)
            }
        }
    }
    else
    {
        print("No ContentGroup found")
    }
    return contentGroup
}

public func saveAboutMeReponse(questionID:String, dateAdded:NSDate, responseValue:String)
{
    do
    {
        let theUserResponse:AboutMeResponse = NSEntityDescription.insertNewObjectForEntityForName("AboutMeResponse", inManagedObjectContext: dbContext) as! AboutMeResponse
        theUserResponse.questionID = questionID
        theUserResponse.dateAdded = dateAdded
        theUserResponse.responseValue = responseValue
        //save to coredata
        try dbContext.save()
        print("AboutMeResponse saved")
    }
    catch let error as NSError
    {
        print("Save AboutMe Response failed: \(error.localizedDescription)")
    }
}

public func getAboutMeResponse(questionID:String)->AboutMeResponse?
{
    do
    {
        // check if given meta exists
        let fetchRequest = NSFetchRequest(entityName: "AboutMeResponse")
        fetchRequest.predicate = NSPredicate(format: "questionID == \"\(questionID)\"")
        
        //get the latest record
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as? [AboutMeResponse]
        
        var theAboutMeResponse:AboutMeResponse!
        if (fetchResults?.count>0){
            theAboutMeResponse = fetchResults?[0]
            print("Found AboutMeResponse with QuestionID: \(theAboutMeResponse.questionID)")
        } else {
            print("No AboutMeResponse Found with a matching record for questionID:\(questionID)")
        }
        
        return theAboutMeResponse
    }
    catch let error as NSError
    {
        print("fetch failed for AboutMeResponse: \(error.localizedDescription)")
    }
    return nil
}

public func getMostRecentAboutMeResponses() -> [AboutMeResponse]?
{
    let QuestionIDArray: [String] = ["AMQ_1", "AMQ_2", "AMQ_3", "AMQ_4", "AMQ_5", "AMQ_6", "AMQ_7", "AMQ_8", "AMQ_9", "AMQ_10"]
    var abtMeResponseArray = [AboutMeResponse]()
    for questionID in QuestionIDArray
    {
        let abtMeResponse = self.getAboutMeResponse(questionID)
        if abtMeResponse != nil
        {
            abtMeResponseArray.append(abtMeResponse!)
        }
    }
    return abtMeResponseArray
}
public func getAllAboutMeResponses() -> [AboutMeResponse]?
{
    do
    {
        let fetchRequest = NSFetchRequest(entityName: "AboutMeResponse")
        let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as? [AboutMeResponse]
        
        let c: Int! = fetchResults?.count
        
        var s = "found \(c) About me responses: \n"
        var m:AboutMeResponse!
        
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            s += m.toString() + "\n"
        }
        print("\(s)")
        return fetchResults

    }
    catch let error as NSError
    {
        print("fetch failed to get  all AboutMeResponse: \(error.localizedDescription)")
    }
    return nil
}
public func getResponsesToBeSynched() -> [AboutMeResponse]?
{
    do
    {
        let fetchRequest = NSFetchRequest(entityName: "AboutMeResponse")
        let fetchResults = try dbContext!.executeFetchRequest(fetchRequest) as? [AboutMeResponse]
        
        let c: Int! = fetchResults?.count
        let synchDate = getMetaDataValue("SynchResponseDate")
        
        var s = "found \(c) About me responses: \n"
        var m:AboutMeResponse!
        var responses = [AboutMeResponse]()
        if synchDate != ""
        {
            for var i = 0; i < c; i++ {
                m = fetchResults?[i]
                if m.dateAdded.isGreaterThanDate(GeneralHelper.convertStringToDate(synchDate))
                {
                    responses.append(m)
                }
                s += m.toString() + "\n"
            }
            print("\(s)")
        }
        else
        {
            responses = fetchResults!
        }
        return responses
    }
    catch let error as NSError
    {
        print("fetch failed to get  all AboutMeResponse to be Synched: \(error.localizedDescription)")
    }
    return nil
}

public func getResponsesToBeDeleted() -> [AboutMeResponse]?
{
    do
    {
        let QuestionIDArray: [String] = ["AMQ_1", "AMQ_2", "AMQ_3", "AMQ_4", "AMQ_5", "AMQ_6", "AMQ_7", "AMQ_8", "AMQ_9", "AMQ_10", "AMQ_11"]
        let gHelpers = GeneralHelper()
        
        var abtMeResponseArray = [AboutMeResponse]()
        for questionID in QuestionIDArray
        {
            // check if given meta exists
            let fetchRequest = NSFetchRequest(entityName: "AboutMeResponse")
            fetchRequest.predicate = NSPredicate(format: "questionID == \"\(questionID)\"")
            
            
            var fetchResults:Array<AboutMeResponse> = try (dbContext!.executeFetchRequest(fetchRequest) as? [AboutMeResponse])!
            let c: Int! = fetchResults.count
            var theAboutMeResponse:AboutMeResponse!
            if (c > 1){
                fetchResults.sortInPlace({gHelpers.convertDateToString($0.dateAdded) < gHelpers.convertDateToString($1.dateAdded)})
                for var i = 0; i < c - 1; i++ {
                    theAboutMeResponse = fetchResults[i]
                    abtMeResponseArray.append(theAboutMeResponse!)
                }
            }
            
        }
        return abtMeResponseArray
    }
    catch let error as NSError
    {
        print("fetch failed to get AboutMeResponse to be deleted: \(error.localizedDescription)")
    }
    return nil
}

public func deleteAboutMeResponse(aboutMeResponse:AboutMeResponse)
{
    //Delete TechnicalLog object from CoreData
    dbContext.deleteObject(aboutMeResponse)
}

}
