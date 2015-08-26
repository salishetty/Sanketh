//
//  UXHelpers.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 8/18/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int, alpha:Float = 1.0) {
        self.init(red: CGFloat((hex >> 16) & 0xff) / 255.0, green: CGFloat((hex >> 8) & 0xff) / 255.0, blue: CGFloat((hex >> 0) & 0xff) / 255.0, alpha: CGFloat(alpha))
    }

    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
     
    convenience init(alphaHex:Int) {
        self.init(red: CGFloat((alphaHex >> 24) & 0xff) / 255.0, green: CGFloat((alphaHex >> 16) & 0xff) / 255.0, blue: CGFloat((alphaHex >> 8) & 0xff) / 255.0, alpha:CGFloat((alphaHex >> 0) & 0xff) / 255.0)
    }
}


class ImageHelpers {
    
    class func resizeToSize(let image: UIImage, let size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    class func resizeToHeight(image: UIImage, height: CGFloat) -> UIImage {
        
        let scale = height / image.size.height
        let width = image.size.width * scale
        UIGraphicsBeginImageContext(CGSizeMake(width, height))
        image.drawInRect(CGRectMake(0, 0, width, height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}


class ViewHelpers
{
    class func setStatusBarTint(view:UIView)
    {
        //Tint for status bar
        let tintViewForStatusBar : UIView = UIView(frame: CGRectMake(0, 0,view.frame.size.width, 20))
        tintViewForStatusBar.backgroundColor = UIColor(hex:0x5DB8DB,alpha:0.7)
        view.addSubview(tintViewForStatusBar)
    }
    
}

