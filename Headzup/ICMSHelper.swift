//
//  ICMSHelper.swift
//  Headzup
//
//  Created by Abebe Woreta on 9/25/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
import SwiftyJSON
public class ICMSHelper
{
    public static func processContent(jsonData: JSON?, dataMgr:DataManager)
    {
        if let parseJSON:JSON = jsonData {
            
            var viewAllContentIDs:String = ""
            //Declare array of ContentIDs which are of Intervention Type
            var contentIDsArray: [String] = []
            for (_, category) in parseJSON
            {
                var contentIDs: String = ""
                var contAudioPath:String = ""
                var contImagePath:String = ""
                
                let categoryID = category["CategoryID"].stringValue
                let categoryName = category["CategoryName"].stringValue
                
                print("Category ID:\(categoryID) with name \(categoryName)")
                let contents = category["Contents"]
                for (_, content) in contents
                {
                    let contentID = content["ContentId"].stringValue
                    contentIDs += contentID + ","
                    let contentName = content["ContentName"].stringValue
                    let contentValue = content["ContentValue"].stringValue
                    let contentDescription = content["Description"].stringValue
                    print("content ID:\(contentID) with name \(contentName) : \(contentValue) :\(contentDescription)")
                    let properties = content["ContentProperties"]
                    
                    for (_, property) in properties
                    {
                        let propertyId = property["PropertyID"].stringValue
                        let propertyValue = property["PropertyValue"].stringValue
                        let contentID = property["ContentID"].stringValue
                        if (propertyId == ICMSProperty.HeadzupContentType && propertyValue == ContentKeys.Intervention)
                        {
                            contentIDsArray.append(contentID)
                        }
                        else if propertyId == ICMSProperty.HeadzupImagePath
                        {
                            contImagePath = propertyValue
                        }
                        else if propertyId == ICMSProperty.HeadzupAudioPath
                        {
                            contAudioPath = propertyValue
                        }
                    
                        print("property ID:\(propertyId) with value \(propertyValue)")
                    }
                    dataMgr.saveContent(GeneralHelper.convertStringToNSNumber(contentID), contentName: contentName, contentDescription: contentDescription, contentValue: contentValue, contentType: "", imagePath: contImagePath, audioPath: contAudioPath)
                    viewAllContentIDs += contentID + ","
                }
                dataMgr.saveContentCategory(Int(categoryID)!, categoryName: categoryName, contentIDs: String(contentIDs.characters.dropLast()))
            }
           
            //Save 'View All' data to Categories - Given a categoryID of "0" - DO NOT CHANGE T. This value is used in ToolBoxViewController
            dataMgr.saveContentCategory(0, categoryName: "View All", contentIDs: String(viewAllContentIDs.characters.dropLast()))
            
            //Save those contents with type = Intervention to 'ContentGroup'
            for contID in contentIDsArray
            {
                let groupType = GeneralHelper.convertStringToNSNumber(GroupType.OMG)
                let contentID = GeneralHelper.convertStringToNSNumber(contID)
                dataMgr.saveContentGroup(groupType, dateModified: NSDate(), contentID: contentID, isActive: false)
            }

    }
}
}
