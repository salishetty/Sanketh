//
//  CustomButton.swift
//  Headzup
//
//  Created by Matt Solano on 8/11/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 8
    @IBInspectable var ViewButtonColor: UIColor?
    @IBInspectable var ViewShadowColor: UIColor = UIColor(red: 135/255, green: 36/255, blue: 240/255, alpha: 1.0)
    @IBInspectable var ViewShadowHeight: CGFloat = 4
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func drawRect(rect: CGRect) {
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.backgroundColor = ViewButtonColor?.CGColor
        
        //superview is your optional embedding UIView
        if let superview = superview {
            superview.backgroundColor = UIColor.clearColor()
            //superview.layer.shadowColor = UIColor.blueColor().CGColor
            superview.layer.shadowColor = ViewShadowColor.CGColor
            superview.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).CGPath
            superview.layer.shadowOffset = CGSize(width: 0.0, height: ViewShadowHeight)
            superview.layer.shadowOpacity = 1.0
            superview.layer.shadowRadius = 0
            superview.layer.masksToBounds = true
            superview.clipsToBounds = false
            
            var viewHeight = superview.frame.height
            var viewWidth = superview.frame.width
            layer.frame.size.height = viewHeight
            layer.frame.size.width = viewWidth
            
        }
    }

}
