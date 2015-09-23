/// Swift Migrator:
///
/// This file contains one or more places using either an index
/// or a range with ArraySlice. While in Swift 1.2 ArraySlice
/// indices were 0-based, in Swift 2.0 they changed to match the
/// the indices of the original array.
///
/// The Migrator wrapped the places it found in a call to the
/// following function, please review all call sites and fix
/// incides if necessary.
@available(*, deprecated=2.0, message="Swift 2.0 migration: Review possible 0-based index")
private func __reviewIndex__<T>(value: T) -> T {
    return value
}

//
//  ChaCha20.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/15/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

final public class ChaCha20 {
    
    static let blockSize = 64 // 512 / 8
    private let stateSize = 16
    private var context:Context?
    
    final private class Context {
        var input:[UInt32] = [UInt32](count: 16, repeatedValue: 0)
        
        deinit {
            for (var i = 0; i < input.count; i++) {
                input[i] = 0x00;
            }
        }
    }
    
    public init?(key:[UInt8], iv:[UInt8]) {
        if let c = contextSetup(iv: iv, key: key) {
            context = c
        } else {
            return nil
        }
    }
    
    convenience public init?(key:String, iv:String) {
        if let kkey = key.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.arrayOfBytes(), let iiv = iv.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)?.arrayOfBytes() {
            self.init(key: kkey, iv: iiv)
        } else {
            self.init(key: [UInt8](), iv: [UInt8]()) //FIXME: this is due Swift bug, remove this line later, when fixed
            return nil
        }
    }
    
    
    public func encrypt(bytes:[UInt8]) -> [UInt8]? {
        if (context == nil) {
            return nil
        }
        
        return encryptBytes(bytes)
    }
    
    public func decrypt(bytes:[UInt8]) -> [UInt8]? {
        return encrypt(bytes)
    }
    
    private final func wordToByte(input:[UInt32] /* 64 */) -> [UInt8]? /* 16 */ {
        if (input.count != stateSize) {
            return nil;
        }
        
        var x = input
        
        var i = 10
        while (i  > 0) {
            quarterround(&x[0], &x[4], &x[8], &x[12])
            quarterround(&x[1], &x[5], &x[9],  &x[13])
            quarterround(&x[2], &x[6], &x[10], &x[14])
            quarterround(&x[3], &x[7], &x[11], &x[15])
            quarterround(&x[0], &x[5], &x[10], &x[15])
            quarterround(&x[1], &x[6], &x[11], &x[12])
            quarterround(&x[2], &x[7], &x[8],  &x[13])
            quarterround(&x[3], &x[4], &x[9],  &x[14])
            i -= 2
        }
        
        var output = [UInt8]()
        output.reserveCapacity(16)
        
        for i in 0..<16 {
            x[i] = x[i] &+ input[i]
           
            //Added by sandeep to reduce complexity of below commented line
            let byte1val = UInt8((x[i] & 0xFF) >> 0)
            let byte2val = UInt8((x[i] & 0xFFFF) >> 8)
            let byte3val = UInt8((x[i] & 0xFFFFFF) >> 16)
            let byte4val = UInt8((x[i] & 0xFFFFFFFF) >> 24)
            output += [byte4val,byte3val,byte2val,byte1val]
            
            //commented for xcode7
//            output += [UInt8((x[i] & 0xFFFFFFFF) >> 24),
//                UInt8((x[i] & 0xFFFFFF) >> 16),
//                UInt8((x[i] & 0xFFFF) >> 8),
//                UInt8((x[i] & 0xFF) >> 0)]
            
            
        }
        
        return output;
    }
    
    private func contextSetup(iv  iv:[UInt8], key:[UInt8]) -> Context? {
        let ctx = Context()
        let kbits = key.count * 8
        
        if (kbits != 128 && kbits != 256) {
            return nil
        }
        
        // 4 - 8
        for (var i = 0; i < 4; i++) {
            let start = i * 4
            ctx.input[i + 4] = wordNumber(key[start..<(start + 4)])
        }
        
        var addPos = 0;
        switch (kbits) {
        case 256:
            addPos += 16
            // sigma
            ctx.input[0] = 0x61707865 //apxe
            ctx.input[1] = 0x3320646e //3 dn
            ctx.input[2] = 0x79622d32 //yb-2
            ctx.input[3] = 0x6b206574 //k et
        default:
            // tau
            ctx.input[0] = 0x61707865 //apxe
            ctx.input[1] = 0x3620646e //6 dn
            ctx.input[2] = 0x79622d31 //yb-1
            ctx.input[3] = 0x6b206574 //k et
            break;
        }
        
        // 8 - 11
        for (var i = 0; i < 4; i++) {
            let start = addPos + (i*4)
            
            let bytes = key[start..<(start + 4)]
            ctx.input[i + 8] = wordNumber(bytes)
        }
        
        // iv
        ctx.input[12] = 0
        ctx.input[13] = 0
        ctx.input[14] = wordNumber(iv[0..<4])
        ctx.input[15] = wordNumber(iv[4..<8])
        
        return ctx
    }
    
    private final func encryptBytes(message:[UInt8]) -> [UInt8]? {
        
        if let ctx = context {
            var c:[UInt8] = [UInt8](count: message.count, repeatedValue: 0)
            
            var cPos:Int = 0
            var mPos:Int = 0
            var bytes = message.count
            
            while (true) {
                if let output = wordToByte(ctx.input) {
                    ctx.input[12] = ctx.input[12] &+ 1
                    if (ctx.input[12] == 0) {
                        ctx.input[13] = ctx.input[13] &+ 1
                        /* stopping at 2^70 bytes per nonce is user's responsibility */
                    }
                    if (bytes <= ChaCha20.blockSize) {
                        for (var i = 0; i < bytes; i++) {
                            c[i + cPos] = message[i + mPos] ^ output[i]
                        }
                        return c
                    }
                    for (var i = 0; i < ChaCha20.blockSize; i++) {
                        c[i + cPos] = message[i + mPos] ^ output[i]
                    }
                    bytes -= ChaCha20.blockSize
                    cPos += ChaCha20.blockSize
                    mPos += ChaCha20.blockSize
                }
            }
        }
        return nil;
    }
    
    private final func quarterround(inout a:UInt32, inout _ b:UInt32, inout _ c:UInt32, inout _ d:UInt32) {
        a = a &+ b
        d = rotateLeft((d ^ a), n: 16)
        
        c = c &+ d
        b = rotateLeft((b ^ c), n: 12);
        
        a = a &+ b
        d = rotateLeft((d ^ a), n: 8);
        
        c = c &+ d
        b = rotateLeft((b ^ c), n: 7);
    }
}

// MARK: Helpers

/// Change array to number. It's here because arrayOfBytes is too slow
private func wordNumber(bytes:ArraySlice<UInt8>) -> UInt32 {
    var value:UInt32 = 0
    for (var i:UInt32 = 0, j = 0; i < 4; i++, j++) {
        value = value | UInt32(bytes[__reviewIndex__(j)]) << (8 * i)
    }
    return value
}
