//
//  Category.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/29/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class Category: NSManagedObject {

    @NSManaged var categoryID: NSNumber
    @NSManaged var categoryName: String
    @NSManaged var contentIDs: String

}
