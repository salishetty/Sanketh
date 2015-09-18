//
//  AboutMeResponseItemsDTO.swift
//  Headzup
//
//  Created by Abebe Woreta on 9/18/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public class ResponseItems
{
    var membershipUserId:String
    var questionID:String
    var responseValue:String
    var dateAdded:String
    init(membershipUserId:String, questionID:String, responseValue:String, dateAdded:String)
    {
        self.membershipUserId = membershipUserId
        self.questionID = questionID
        self.responseValue = responseValue
        self.dateAdded = dateAdded
    }
}
