//
//  IntExtension.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/15/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

/* array of bits */
extension Int {
    init(bits: [Bit]) {
        self.init(bitPattern: integerFromBitsArray(bits) as UInt)
    }
}

/* array of bytes */
extension Int {
    /** Array of bytes with optional padding (little-endian) */
    public func bytes(totalBytes: Int = sizeof(Int)) -> [UInt8] {
        return arrayOfBytes(self, length: totalBytes)
    }
    
    public static func withBytes(bytes: ArraySlice<UInt8>) -> Int {
        return Int.withBytes(Array(bytes))
    }
    
    /** Int with array bytes (little-endian) */
    public static func withBytes(bytes: [UInt8]) -> Int {
        return integerWithBytes(bytes)
    }
}



/** Shift bits */
extension Int {
    
    /** Shift bits to the left. All bits are shifted (including sign bit) */
    private mutating func shiftLeft(count: Int) -> Int {
        self = Headzup.shiftLeft(self, count: count)
        return self
    }
    
    /** Shift bits to the right. All bits are shifted (including sign bit) */
    private mutating func shiftRight(count: Int) -> Int {
        if (self == 0) {
            return self;
        }
        
        let bitsCount = sizeofValue(self) * 8
        
        if (count >= bitsCount) {
            return 0
        }
        
        let maxBitsForValue = Int(floor(log2(Double(self)) + 1))
        let shiftCount = Swift.min(count, maxBitsForValue - 1)
        var shiftedValue:Int = 0;
        
        for bitIdx in 0..<bitsCount {
            // if bit is set then copy to result and shift left 1
            let bit = 1 << bitIdx
            if ((self & bit) == bit) {
                shiftedValue = shiftedValue | (bit >> shiftCount)
            }
        }
        self = Int(shiftedValue)
        return self
    }
}

// Left operator

/** shift left and assign with bits truncation */
public func &<<= (inout lhs: Int, rhs: Int) {
    lhs.shiftLeft(rhs)
}

/** shift left with bits truncation */
public func &<< (lhs: Int, rhs: Int) -> Int {
    var l = lhs;
    l.shiftLeft(rhs)
    return l
}

// Right operator

/** shift right and assign with bits truncation */
func &>>= (inout lhs: Int, rhs: Int) {
    lhs.shiftRight(rhs)
}

/** shift right and assign with bits truncation */
func &>> (lhs: Int, rhs: Int) -> Int {
    var l = lhs;
    l.shiftRight(rhs)
    return l
}
