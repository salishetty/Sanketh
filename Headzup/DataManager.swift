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
        if let fetchResults = super.fetchEntity("MetaData", key: "name", value: name)
        {
             var metaData:[MetaData] = fetchResults as! [MetaData]
            let theMetaData :MetaData! = metaData[0]
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
        }
        else
        {
            print("Cannot find matching MetaData for \(name)")
        }
        return retVal
    }
    
    public func getAllMetaData() -> [MetaData]?{
        if let fetchResults = super.fetchEntity("MetaData")
        {
            let metaData:[MetaData] = fetchResults as! [MetaData]
            let c: Int! = fetchResults.count
            var s = "found \(c) MetaData: \n"
            var theMetaData:MetaData!
            for var i = 0; i < c; i++
            {
                theMetaData = metaData[i]
                s += theMetaData.toString() + "\n"
            }
            print("\(s)")
            return metaData
        }
        else
        {
            print("No MataData found")
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
        do
        {
            var theProperties: [String: AnyObject] = [:]
            var theContent:Content!
            if let fetchResults = super.fetchEntity("Content", key: "contentID", value: contentID.stringValue)
            {
                var content:[Content] = fetchResults as! [Content]
                theContent = content[0]
                print("found Content \(theContent.toString())")
                theContent.contentName = contentName
                theContent.contentValue = contentValue
                theContent.contentDescription = contentDescription
                theContent.imagePath = imagePath
                theContent.audioPath = audioPath
                try super.managedContext.save()
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
                print("Content Saved: \(theContent.toString())")
            }

        }
        catch let error as NSError
        {
            print("Error saving Content: \(error.localizedDescription) ")
        }
    }
    
    public func getAllContents() -> [Content]?
    {
        if let fetchResults = super.fetchEntity("Content")
        {
            let content:[Content] = fetchResults as! [Content]
            let c: Int! = fetchResults.count
            var s = "found \(c) Contents: \n"
            var theContent:Content!
            for var i = 0; i < c; i++
            {
                theContent = content[i]
                s += theContent.toString() + "\n"
            }
            print("\(s)")
            return content
        }
        else
        {
            print("No Contents found")
        }
        return nil
    }
    public func getContentByID(contentID:Int)->Content?
    {
        var theContent:Content!
        if let fetchResults = super.fetchEntity("Content", key: "contentID", value: String(contentID))
        {
            var content:[Content] = fetchResults as! [Content]
            theContent = content[0]
            print("found Content: \(theContent?.contentName)")
        }
        else
        {
            print("Cannot find matching Content for \(contentID)")
        }
        return theContent
    }
    
    public func getContentByIDs(contentIDs:String) ->[Content]?
    {
        let contentIDsArray = contentIDs.componentsSeparatedByString(",")
        var theContentArray = [Content]()
        var contentID:String?
        for var i = 0; i < contentIDsArray.count; i++ {
            contentID = contentIDsArray[i]
            
            let fomattedContentID = NSNumberFormatter().numberFromString(contentID!)
            let newContentID = fomattedContentID!.integerValue
            var theContent:Content!
            if let fetchResults = super.fetchEntity("Content", key: "contentID", value: String(newContentID))
            {
                let content:[Content] = fetchResults as! [Content]
                theContent = content[0]
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
    
    public func getCategoryByID(categoryID:Int)->Category?
    {
        var theCategory:Category!
        if let fetchResults = super.fetchEntity("Category", key: "categoryID", value: String(categoryID))
        {
            var category:[Category] = fetchResults as! [Category]
            theCategory = category[0]
            print("found Category with Category Name: \(theCategory?.categoryName)")
        }
        else
        {
            print("Cannot find matching Category for \(categoryID)")
        }
        return theCategory
     }
    
    public func saveContentCategory(categoryID:Int, categoryName:String, contentIDs:String)
    {
        do
        {
            var theProperties: [String: AnyObject] = [:]
            var theCategory:Category!
            if let fetchResults = super.fetchEntity("Category", key: "categoryID", value: String(categoryID))
            {
                var category:[Category] = fetchResults as! [Category]
                theCategory = category[0]
                print("found Category \(theCategory.toString())")
                theCategory.categoryName = categoryName
                theCategory.contentIDs = contentIDs
                try super.managedContext.save()
            }
            else
            {
                print("creating new Category: \(categoryID) : \(categoryName)")
                theProperties["categoryID"] = categoryID
                theProperties["categoryName"] = categoryName
                theProperties["contentIDs"] = contentIDs
                theCategory = super.saveEntity("Category", properties: theProperties) as! Category
                print("Category Saved: \(theCategory.toString())")
            }

        }
        catch let error as NSError
        {
            print("Error saving Category: \(error.localizedDescription) ")
        }
    }
public func getAllcategories() -> [Category]?
{
    if let fetchResults = super.fetchEntity("Category")
    {
        let category:[Category] = fetchResults as! [Category]
        let c: Int! = fetchResults.count
        var s = "found \(c) Categories: \n"
        var theCategory:Category!
        for var i = 0; i < c; i++
        {
            theCategory = category[i]
            s += theCategory.toString() + "\n"
        }
        print("\(s)")
        return category
    }
    else
    {
        print("No categories found")
    }
    return nil
}
//Methods for UserAction Entity

public func saveUserActionLog(actionType:String, actionDateTime:NSDate,contentID:String, comment:String, isSynched:Bool)
{
    var theProperties: [String: AnyObject] = [:]
    
    theProperties["osVersion"] = UIDevice.currentDevice().systemVersion
    theProperties["appVersion"] = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! String
    theProperties["actionType"] = actionType
    theProperties["actionDateTime"] = actionDateTime
    theProperties["contentID"] = contentID
    theProperties["comment"] = comment
    theProperties["isSynched"] = isSynched
    super.saveEntity("UserActionLog", properties: theProperties) as! UserActionLog
    print("UserActionLog saved)")
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
    var theProperties: [String: AnyObject] = [:]
    theProperties["message"] = message
    theProperties["exception"] = exception
    theProperties["moduleName"] = moduleName
    theProperties["eventDate"] = eventDate
    theProperties["osVersion"] = UIDevice.currentDevice().systemVersion
    theProperties["appVersion"] = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! String
    theProperties["logLevel"] = logLevel
    theProperties["isSynched"] = isSynched
    super.saveEntity("TechnicalLog", properties: theProperties) as! TechnicalLog
    print("TechnicalLog saved)")

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
        var theProperties: [String: AnyObject] = [:]
        var theAboutMeResponse:AboutMeResponse!
        if let fetchResults = super.fetchEntity("AboutMeResponse", key: "questionID", value: questionID)
        {
            var aboutMeResponse:[AboutMeResponse] = fetchResults as! [AboutMeResponse]
            theAboutMeResponse = aboutMeResponse[0]
            theAboutMeResponse.responseValue = responseValue
            theAboutMeResponse.dateAdded = dateAdded
            try super.managedContext.save()
            print("found AboutMeResponse \(theAboutMeResponse.toString())")
        }
        else {
            print("creating new AboutMeResponse: \(questionID) : \(responseValue)")
            theProperties["questionID"] = questionID
            theProperties["dateAdded"] = dateAdded
            theProperties["responseValue"] = responseValue
            theAboutMeResponse = super.saveEntity("AboutMeResponse", properties: theProperties) as! AboutMeResponse
            print("Content Saved: \(theAboutMeResponse.toString())")
        }
     }
    catch let error as NSError
    {
        print("Error Saving About Me response: \(error.localizedDescription) ")
    }
}

public func getAboutMeResponse(questionID:String)->AboutMeResponse?
{
    var theAboutMeResponse:AboutMeResponse!
    if let fetchResults = super.fetchEntity("AboutMeResponse", key: "questionID", value: questionID)
    {
        var aboutMeResponse:[AboutMeResponse] = fetchResults as! [AboutMeResponse]
        theAboutMeResponse = aboutMeResponse[0]
        print("Found AboutMeResponse with responseValue: \(theAboutMeResponse.responseValue)")
    }
    else
    {
        print("No AboutMeResponse Found with a matching record for questionID:\(questionID)")
    }
    return theAboutMeResponse
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
public func getResponsesTobeSynched() -> [AboutMeResponse]?
{
    var theAboutMeResponse:AboutMeResponse!
    var aboutMeResponses = [AboutMeResponse]()
    let synchDate = getMetaDataValue("SynchResponseDate")
    if let fetchResults = super.fetchEntity("AboutMeResponse")
    {
        let c: Int! = fetchResults.count
        var s = "found \(c) About me responses: \n"
        if synchDate != ""
        {
            for var i = 0; i < c; i++ {
                theAboutMeResponse = fetchResults[i] as! AboutMeResponse
                if theAboutMeResponse.dateAdded.isGreaterThanDate(GeneralHelper.convertStringToDate(synchDate))
                {
                    aboutMeResponses.append(theAboutMeResponse)
                }
                s += theAboutMeResponse.toString() + "\n"
            }
            print("\(s)")
        }
        else
        {
            aboutMeResponses = fetchResults as! [AboutMeResponse]
        }
        
    }
    else
    {
        print("No AboutMeResponse Found with a matching record")
    }
    return aboutMeResponses
}

public func getResponsesToBeDeleted() -> [AboutMeResponse]?
{
    do
    {
        let QuestionIDArray: [String] = ["AMQ_1", "AMQ_2", "AMQ_3", "AMQ_4", "AMQ_5", "AMQ_6", "AMQ_7", "AMQ_8", "AMQ_9", "AMQ_10", "AMQ_11"]
        
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
                fetchResults.sortInPlace({GeneralHelper.convertDateToString($0.dateAdded) < GeneralHelper.convertDateToString($1.dateAdded)})
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

    public func saveTrackerResponse(trackDate:NSDate, hadHeadache:NSNumber, painLevel:NSNumber, affectSleep:NSNumber, affectActivity:NSNumber, painReasons:String, helpfulContent:String)
    {
        do
        {
            var theProperties: [String: AnyObject] = [:]
            var trackerResponseCurrentDay:TrackerResponse!
            var trackerResponsePreviousDay:TrackerResponse!
            let today = NSDate()
            
            
            let previousDate:NSDate
            
            let order = NSCalendar.currentCalendar().compareDate(today, toDate: trackDate,
                toUnitGranularity: .Day)
            
            if order == .OrderedSame
            {
                previousDate = NSCalendar.currentCalendar().dateByAddingUnit(
                    .Day,
                    value: -1,
                    toDate: trackDate,
                    options: NSCalendarOptions(rawValue: 0))!
            }
            else
            {
                previousDate = trackDate
            }
            
            // First moment of a given date
            let startOfPreviousDay = previousDate.beginningOfDay() //NSCalendar.currentCalendar().startOfDayForDate(date)
            print("Start of Previous Day\(startOfPreviousDay)")
            
            
//            let yesterday = NSCalendar.currentCalendar().dateByAddingUnit(
//                .Day,
//                value: -1,
//                toDate: trackDate,
//                options: NSCalendarOptions(rawValue: 0))
//            
//            // Given date
//            //let date = NSDate()
//            
//            // First moment of a given date
//            let startOfPreviousDay = yesterday!.beginningOfDay() //NSCalendar.currentCalendar().startOfDayForDate(date)
//            print("Start of Day\(startOfPreviousDay)")
            
            
            
            let fetchRequest = NSFetchRequest(entityName: "TrackerResponse")
            fetchRequest.predicate = NSPredicate(format: "trackDate >= %@", startOfPreviousDay)
            if let fetchResult = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
                if fetchResult.count > 0 {
                    var trackerResponse:[TrackerResponse] = fetchResult as! [TrackerResponse]
                    
                    if trackerResponse.count == 2
                    {
                        trackerResponsePreviousDay = trackerResponse[0]
                        trackerResponseCurrentDay = trackerResponse[1]
                        print("Found TrackerResponse with the TrackDate: \(trackerResponseCurrentDay.trackDate)")
                        print("Found TrackerResponse with the TrackDate: \(trackerResponsePreviousDay.trackDate)")
                        //Compare trackDate with today's date without including time
                        let order = NSCalendar.currentCalendar().compareDate(today, toDate: trackDate,
                            toUnitGranularity: .Day)
                        
                        switch order {
                            //if they are the same, update currentDay's record
                        case .OrderedSame:
                            print("Found TrackerResponse with the TrackDate: \(trackerResponseCurrentDay.trackDate)")
                            trackerResponseCurrentDay.trackDate = trackDate
                            trackerResponseCurrentDay.hadHeadache = hadHeadache
                            trackerResponseCurrentDay.painLevel = painLevel
                            trackerResponseCurrentDay.affectSleep = affectSleep
                            trackerResponseCurrentDay.affectActivity = affectActivity
                            trackerResponseCurrentDay.painReasons = painReasons
                            trackerResponseCurrentDay.helpfulContent = helpfulContent
                            try super.managedContext.save()
                            //Otherwise update yesterday's record
                        default:
                            print("Found TrackerResponse with the TrackDate: \(trackerResponsePreviousDay.trackDate)")
                            trackerResponsePreviousDay.trackDate = trackDate
                            trackerResponsePreviousDay.hadHeadache = hadHeadache
                            trackerResponsePreviousDay.painLevel = painLevel
                            trackerResponsePreviousDay.affectSleep = affectSleep
                            trackerResponsePreviousDay.affectActivity = affectActivity
                            trackerResponsePreviousDay.painReasons = painReasons
                            trackerResponsePreviousDay.helpfulContent = helpfulContent
                            try super.managedContext.save()
                            
                        }
                    }
                    else
                    {
                        let theTrackerResponse = trackerResponse[0]
                        print("Found TrackerResponse with the TrackDate: \(theTrackerResponse.trackDate)")
                        
                        let order = NSCalendar.currentCalendar().compareDate(theTrackerResponse.trackDate, toDate: trackDate,
                            toUnitGranularity: .Day)
                        
                        if order == .OrderedSame
                        {
                            theTrackerResponse.trackDate = trackDate
                            theTrackerResponse.hadHeadache = hadHeadache
                            theTrackerResponse.painLevel = painLevel
                            theTrackerResponse.affectSleep = affectSleep
                            theTrackerResponse.affectActivity = affectActivity
                            theTrackerResponse.painReasons = painReasons
                            theTrackerResponse.helpfulContent = helpfulContent
                            try super.managedContext.save()
                        }
                        else
                        {
                            print("creating new TrackerResponse: \(trackDate) : \(hadHeadache)")
                            theProperties["trackDate"] = trackDate
                            theProperties["hadHeadache"] = hadHeadache
                            theProperties["painLevel"] = painLevel
                            theProperties["affectSleep"] = affectSleep
                            theProperties["affectActivity"] = affectActivity
                            theProperties["painReasons"] = painReasons
                            theProperties["helpfulContent"] = helpfulContent
                            trackerResponseCurrentDay = super.saveEntity("TrackerResponse", properties: theProperties) as! TrackerResponse
                            print("Tracker response Saved: \(trackerResponseCurrentDay.toString())")
                        }
                    }
                }
                else
                {
                    print("creating new TrackerResponse: \(trackDate) : \(hadHeadache)")
                    theProperties["trackDate"] = trackDate
                    theProperties["hadHeadache"] = hadHeadache
                    theProperties["painLevel"] = painLevel
                    theProperties["affectSleep"] = affectSleep
                    theProperties["affectActivity"] = affectActivity
                    theProperties["painReasons"] = painReasons
                    theProperties["helpfulContent"] = helpfulContent
                    trackerResponseCurrentDay = super.saveEntity("TrackerResponse", properties: theProperties) as! TrackerResponse
                    print("Tracker response Saved: \(trackerResponseCurrentDay.toString())")
                }

            }
        }
        catch let error as NSError
        {
            print("Error updating TrackerResponse) : \(error.localizedDescription) ")
        }

    }
    
    public func getTrackerResponse(trackDate:NSDate)->TrackerResponse?
    {
        var theTrackerResponse:TrackerResponse!
        do
        {
            let today = NSDate()
            let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit(
                .Day,
                value: 1,
                toDate: today,
                options: NSCalendarOptions(rawValue: 0))
            
            
            let yesterday = NSCalendar.currentCalendar().dateByAddingUnit(
                .Day,
                value: -1,
                toDate: today,
                options: NSCalendarOptions(rawValue: 0))
            
            //To return ONLY one particular record from CoreData
            let fetchRequest = NSFetchRequest(entityName: "TrackerResponse")
            fetchRequest.predicate = NSPredicate(format: "(trackDate > %@) AND (trackDate < %@)", yesterday!, tomorrow!)
            if let fetchResult = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
                if fetchResult.count > 0 {
                    var trackerResponse:[TrackerResponse] = fetchResult as! [TrackerResponse]
                    theTrackerResponse = trackerResponse[0]
                    
                    //Compare by particular date without involving time
                    let order = NSCalendar.currentCalendar().compareDate(today, toDate: theTrackerResponse.trackDate,
                        toUnitGranularity: .Day)

                    switch order {
                    case .OrderedSame:
                        print("Found TrackerResponse with the TrackDate: \(theTrackerResponse.trackDate)")
                        return theTrackerResponse
                    default:
                        print("No TrackerResponse Found with a matching record for trackDate:\(trackDate)")
                        return nil
                      }
                }
            }
            else
            {
                print("No TrackerResponse Found with a matching record for trackDate:\(trackDate)")
            }
            
        }
        catch
        {
            
        }
        
      return theTrackerResponse  
    }
    
    public func getAllTrackerResponses() -> [TrackerResponse]?
    {
        if let fetchResults = super.fetchEntity("TrackerResponse")
        {
            let trackerResponse:[TrackerResponse] = fetchResults as! [TrackerResponse]
            let c: Int! = fetchResults.count
            var s = "found \(c) TrackerResponses: \n"
            var theTrackerResponse:TrackerResponse!
            for var i = 0; i < c; i++
            {
                theTrackerResponse = trackerResponse[i]
                s += theTrackerResponse.toString() + "\n"
            }
            print("\(s)")
            return trackerResponse
        }
        else
        {
            print("No TrackerResponses found")
        }
        return nil
    }

}
