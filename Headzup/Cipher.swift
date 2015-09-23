//
//  Cipher.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/15/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public enum Cipher {
    /**
    ChaCha20
    
    - parameter key: Encryption key
    - parameter iv:  Initialization Vector
    
    - returns: Value of Cipher
    */
    case ChaCha20(key: [UInt8], iv: [UInt8])
    /**
    AES
    
    - parameter key:       Encryption key
    - parameter iv:        Initialization Vector
    - parameter blockMode: Block mode (CBC by default)
    
    - returns: Value of Cipher
    */
    case AES(key: [UInt8], iv: [UInt8], blockMode: CipherBlockMode)
    
    /**
    Encrypt message
    
    - parameter message: Plaintext message
    
    - returns: encrypted message
    */
    public func encrypt(bytes: [UInt8]) -> [UInt8]? {
        switch (self) {
        case .ChaCha20(let key, let iv):
            let chacha = ChaCha20(key: key, iv: iv)
            return chacha.encrypt(bytes)
        case .AES(let key, let iv, let blockMode):
            let aes = AES(key: key, iv: iv, blockMode: blockMode)
            return aes.encrypt(bytes)
        }
    }
    
    /**
    Decrypt message
    
    - parameter message: Message data
    
    - returns: Plaintext message
    */
    public func decrypt(bytes: [UInt8]) -> [UInt8]? {
        switch (self) {
        case .ChaCha20(let key, let iv):
            let chacha = ChaCha20(key: key, iv: iv);
            return chacha.decrypt(bytes)
        case .AES(let key, let iv, let blockMode):
            let aes = AES(key: key, iv: iv, blockMode: blockMode);
            return aes.decrypt(bytes)
        }
    }
    
    static public func randomIV(blockSize:Int) -> [UInt8] {
        var randomIV:[UInt8] = [UInt8]();
        for (var i = 0; i < blockSize; i++) {
            randomIV.append(UInt8(truncatingBitPattern: arc4random_uniform(256)));
        }
        return randomIV
    }
}
