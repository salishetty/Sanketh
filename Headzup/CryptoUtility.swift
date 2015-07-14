//
//  CryptoUtility.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/14/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
public class CryptoUtility
{
    public init()
    {
        
    }
    public func generateSecurityToken() ->NSString {
        
        //Set IV and Key
        let iv:[UInt8] = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let key:[UInt8] = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        
        var requestTime:String = getRequestExpirationTime(10) // Set it to 10 minute for now
        return getEncryptedData(requestTime, iv: iv, key: key)
    }
    
    func isValidSecurityToken(token: NSString) -> Bool {
        return false
    }
    
    public func getRequestExpirationTime(minutes:Int) -> String
    {
        let comps = NSDateComponents()
        
        comps.minute = minutes
        
        let cal = NSCalendar.currentCalendar()
        var nsDate = NSDate()
        
        let date = cal.dateByAddingComponents(comps, toDate: nsDate, options: nil)
        
        //Format the time in UTC
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        formatter.timeStyle = .LongStyle
        
        let formattedDate = formatter.stringFromDate(date!)
        return formattedDate as String
    }
    
    public func getEncryptedData(plainText: String, iv:[UInt8], key:[UInt8])->String
    {
        //1. convert plaintext to byte array
        let plainTextData = [UInt8](plainText.utf8)
        
        
        // 2. encrypt
        
        let encryptedData = AES(key: key, iv: iv, blockMode: .CBC)?.encrypt(plainTextData, padding: PKCS7())
        
        //3. Encoded String
        let nsData:NSData = NSData(bytes: encryptedData!, length: encryptedData!.count)
        let base64EncodedString:NSString = nsData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        println("encode: \(plainText) > \(base64EncodedString)")
        
        return base64EncodedString as String
        
    }
    
    
    
    public func getDecryptedData(encryptedString:String, iv:[UInt8], key:[UInt8])->NSString
    {
        
        //1. Decoded String
        let nsData:NSData = NSData(base64EncodedString: encryptedString, options: NSDataBase64DecodingOptions(rawValue:0))!
        
        //2. Convert to Byte Array
        let encryptedData = base64ToByteArray(encryptedString)
        
        // 3. decrypt with the same key and IV
        let decryptedData = AES(key: key, iv: iv, blockMode: .CBC)?.decrypt(encryptedData, padding: PKCS7())
        
        //4. Convert to NSData
        let nsDecryptedData:NSData = NSData(bytes: decryptedData!, length: decryptedData!.count)
        
        //5. Convert to NSString
        let decryptedString = NSString(data: nsDecryptedData, encoding: NSUTF8StringEncoding)
        
        println("decode: \(encryptedString) > \(decryptedString!)")
        
        return decryptedString!
    }
    
    func stringToByteArray(inputString:String) -> [UInt8]
    {
        var bytes:[UInt8] = []
        for code in inputString.utf8
        {
            bytes.append(UInt8(code))
        }
        return bytes
    }
    
    func base64ToByteArray(base64String:String) ->[UInt8]
    {
        let nsData:NSData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))!
        //create array of the required size
        var bytes = [UInt8](count: nsData.length, repeatedValue: 0)
        //fill it with data
        nsData.getBytes(&bytes, length:40)
        return bytes
        
    }
    
}
