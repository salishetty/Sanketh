//
//  SynchHelper.swift
//  Headzup
//
//  Created by Abebe Woreta on 10/1/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
public class SynchHelper
{
    public static func SynchTailoringQuestions(dataMgr:DataManager) {
        let uInfo = AppContext.getUserInfo()
        let membershipUserID = uInfo.membershipUserID
        var dict = Dictionary<String, String>()
        var responseItemsArray = [String:Dictionary<String, String>]()
        let responsesTobeSynched:[AboutMeResponse] = dataMgr.getResponsesTobeSynched()!
        var index:Int32 = 0
        if responsesTobeSynched.count > 0
        {
            for responseItem in responsesTobeSynched
            {
                print("AboutMeResponse Items: \(responseItem.questionID): \(responseItem.responseValue):\((responseItem.dateAdded))")
                
                let responseItems = ResponseItems(membershipUserId: membershipUserID, questionID: responseItem.questionID, responseValue: responseItem.responseValue, dateAdded: GeneralHelper.convertDateToString(responseItem.dateAdded))
                
                dict = GeneralHelper.responseItemsToDictionary(responseItems)
                responseItemsArray["ResponseItem"+String(index)] = dict
                //update index
                index++
            }
        }
        
        if(responseItemsArray.count > 0)
        {
            let serviceManager = ServiceManager()
            serviceManager.synchAboutMeResponse(responseItemsArray , completion: { (jsonData: JSON?)->() in
                
                if let parseJSON = jsonData {
                    let status = parseJSON["Status"]
                    if(status == 1)
                    {
                        let synchDate = NSDate()
                        dataMgr.saveMetaData("SynchResponseDate", value: GeneralHelper.convertDateToString(synchDate), isSecured: true)
                        print("About Me Response synchronized Successfully")
                    }
                }
                
                }
            )
        }
    }
}
