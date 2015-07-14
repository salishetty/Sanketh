//
//  UInt64Extension.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/15/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

/** array of bytes */
extension UInt64 {
    public func bytes(_ totalBytes: Int = sizeof(UInt64)) -> [UInt8] {
        return arrayOfBytes(self, length: totalBytes)
    }
    
    public static func withBytes(bytes: ArraySlice<UInt8>) -> UInt64 {
        return UInt64.withBytes(Array(bytes))
    }
    
    /** Int with array bytes (little-endian) */
    public static func withBytes(bytes: [UInt8]) -> UInt64 {
        return integerWithBytes(bytes)
    }
}
