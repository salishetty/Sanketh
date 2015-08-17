//
//  FavoriteItemsDTO.swift
//  Headzup
//
//  Created by Abebe Woreta on 8/11/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public class FavoriteItems
{
    var membershipUserId:String
    var groupType:NSNumber
    var contentID:NSNumber
    var isActive:String
    init(membershipUserID:String, groupType:NSNumber, contentID:NSNumber, isActive:String)
    {
        self.membershipUserId = membershipUserID
        self.groupType = groupType
        self.contentID = contentID
        self.isActive = isActive
    }
}
