//
//  ContentGroup.swift
//  Headzup
//
//  Created by Abebe Woreta on 8/11/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class ContentGroup: NSManagedObject {

    @NSManaged var contentID: NSNumber
    @NSManaged var dateModified: NSDate
    @NSManaged var groupType: NSNumber
    @NSManaged var isActive: NSNumber

}
