//
//  FirstAidView.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 8/26/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FirstAidView: UIView {
    
    var ContentTitle: UILabel = UILabel()
    var ContentDescription: UILabel = UILabel()
    var ReadMoreButton:CustomButton = CustomButton()

    init()
    {
        var screenHeight = UIScreen.mainScreen().bounds.height - 150
        var screenWidth =  UIScreen.mainScreen().bounds.width 
        println("screen height: \(screenHeight) and screen width :\(screenWidth)")
        
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        
        initialize()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(){
        
         var contentWidth =  UIScreen.mainScreen().bounds.width - 60
        
        let newView =  UIView()
        newView.backgroundColor = UIColor.whiteColor()
        newView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //Rounded Corner
        newView.layer.cornerRadius = 15.0
        newView.layer.borderColor = UIColor.grayColor().CGColor
        newView.layer.borderWidth = 0.5
        newView.clipsToBounds = true
        
        
        // Title label
        ContentTitle.frame = CGRectMake(10, 20, contentWidth, 30)
        ContentTitle.numberOfLines = 1
        ContentTitle.adjustsFontSizeToFitWidth = true
        ContentTitle.textColor = UIColor(netHex:0x2387CD)
        ContentTitle.textAlignment = NSTextAlignment.Center
        ContentTitle.font = UIFont (name: "Arial Rounded MT Bold", size: 30)
        ContentTitle.text = "Content Title"
        newView.addSubview(ContentTitle)

        // Content Label
        ContentDescription.frame = CGRectMake(10, 75, contentWidth, 30)
        ContentDescription.numberOfLines = 0
        ContentDescription.textAlignment = NSTextAlignment.Justified
        ContentDescription.text = "Content description"
        newView.addSubview(ContentDescription)

        //content button
        var buttonY = UIScreen.mainScreen().bounds.height - 270
        let buttonView =  UIView(frame: CGRectMake(10, buttonY, contentWidth, 50))
        buttonView.backgroundColor = UIColor(netHex:0x78AC2D)
        ReadMoreButton.frame = CGRectMake(0, 0, contentWidth, 50)
        ReadMoreButton.ViewButtonColor = UIColor(netHex:0xB1E100)
        ReadMoreButton.ViewShadowColor = UIColor(netHex:0x78AC2D)
        ReadMoreButton.setTitle("Read More...", forState: UIControlState.Normal)
        ReadMoreButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        buttonView.addSubview(ReadMoreButton)
        ReadMoreButton.titleLabel!.font =  UIFont (name: "Arial Rounded MT Bold", size: 17)
        
        //button.addTarget(self, action: "delAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        newView.addSubview(buttonView)
        
        self.addSubview(newView)
        
        let horizontalCenterConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.addConstraint(horizontalCenterConstraint)
        
        let verticalCenterConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        self.addConstraint(verticalCenterConstraint)
        
        let views = ["newView": newView]

        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[newView]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        self.addConstraints(horizontalConstraints)
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[newView]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        self.addConstraints(verticalConstraints)

        
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
