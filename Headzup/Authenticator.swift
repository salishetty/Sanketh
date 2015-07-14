//
//  Authenticator.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/15/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

/**
*  Message Authentication
*/
public enum Authenticator {
    /**
    Poly1305
    
    :param: key 256-bit key
    */
    case Poly1305(key: [UInt8])
    case HMAC(key: [UInt8], variant: Headzup.HMAC.Variant)
    
    /**
    Generates an authenticator for message using a one-time key and returns the 16-byte result
    
    :returns: 16-byte message authentication code
    */
    public func authenticate(message: [UInt8]) -> [UInt8]? {
        switch (self) {
        case .Poly1305(let key):
            return Headzup.Poly1305.authenticate(key: key, message: message)
        case .HMAC(let key, let variant):
            return Headzup.HMAC.authenticate(key: key, message: message, variant: variant)
        }
    }
}
