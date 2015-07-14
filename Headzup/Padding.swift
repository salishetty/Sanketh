//
//  Padding.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/15/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public protocol Padding {
    func add(data: [UInt8], blockSize:Int) -> [UInt8];
    func remove(data: [UInt8], blockSize:Int?) -> [UInt8];
}
