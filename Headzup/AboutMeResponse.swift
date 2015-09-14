//
//  AboutMeResponse.swift
//  Headzup
//
//  Created by Abebe Woreta on 9/14/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class AboutMeResponse: NSManagedObject {

    @NSManaged var dateAdded: NSDate
    @NSManaged var questionID: String
    @NSManaged var responseValue: String

}
