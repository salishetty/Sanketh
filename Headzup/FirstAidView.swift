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

protocol FirstAidViewDelegate {
    func NavigateToDetails(contentId:Int)
}


class FirstAidView: UIView {
    
    var ContentTitle: UILabel = UILabel()
    var ContentDescription: UILabel = UILabel()
    var ReadMoreView:UIView = UIView()
    var ReadMoreButton:CustomButton = CustomButton()

    var firstAidViewDelegate : FirstAidViewDelegate!
    
    var ContentId:Int = 0
    
    var contentName: String?
    var contentValue: String?
    var buttonText: String
    
    init(firstAid: Content)
    {
        var screenHeight = UIScreen.mainScreen().bounds.height * 0.745
        var screenWidth =  UIScreen.mainScreen().bounds.width
        //Content With Audio
        self.buttonText =  "Tap to read more"
        if let audioPath = firstAid.audioPath as String?
        {
            if (!audioPath.isEmpty)
            {
                self.buttonText =  "Tap to listen"
            }
        }

        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.contentName = firstAid.contentName
        self.contentValue = firstAid.contentValue
        initialize()
        self.ContentId = firstAid.contentID.integerValue
     
    }
    
    

    
    required init(coder aDecoder: NSCoder) {
        self.buttonText =  "Read more"
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(){
        
        let contentView =  UIView()
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //Rounded Corner
        contentView.layer.cornerRadius = 12.0
        contentView.layer.borderColor = UIColor(netHex:0x2387CD).CGColor
        contentView.layer.borderWidth = 0.5
        contentView.clipsToBounds = true
        
        self.addSubview(contentView)
        
        let horizontalCenterConstraint = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.addConstraint(horizontalCenterConstraint)
        
        let verticalCenterConstraint = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        self.addConstraint(verticalCenterConstraint)
        
        let views = ["contentView": contentView ,"ContentTitle":ContentTitle,"ContentDescription":ContentDescription,"ReadMoreView":ReadMoreView,"ReadMoreButton":ReadMoreButton]

        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[contentView]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        self.addConstraints(horizontalConstraints)
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[contentView]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        self.addConstraints(verticalConstraints)

        // Title label
        ContentTitle.numberOfLines = 0
        ContentTitle.textColor = UIColor(netHex:0x2387CD)
        ContentTitle.textAlignment = NSTextAlignment.Center
        ContentTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        ContentTitle.font = UIFont (name: "Arial Rounded MT Bold", size: 25)
        ContentTitle.text = contentName; 
        contentView.addSubview(ContentTitle)
        
        //Content Label
        ContentDescription.numberOfLines = 0
        ContentDescription.textAlignment = NSTextAlignment.Justified
        ContentDescription.font = UIFont (name: "HelveticaNeue", size: 20)
        ContentDescription.textColor = UIColor(netHex:0x606060)
        ContentDescription.setTranslatesAutoresizingMaskIntoConstraints(false)
        ContentDescription.text = contentValue;
         contentView.addSubview(ContentDescription)
        
        //Button View
        ReadMoreView.backgroundColor = UIColor(netHex:0x78AC2D)
        ReadMoreView.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(ReadMoreView)
        
        //View level constraints
        let horizontalTitleConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[ContentTitle]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        contentView.addConstraints(horizontalTitleConstraints)
        
        let horizontalDescConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[ContentDescription]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        contentView.addConstraints(horizontalDescConstraints)

        
        let horizontalBtnViewConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[ReadMoreView]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        contentView.addConstraints(horizontalBtnViewConstraints)
        
        let verticalLabelConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[ContentTitle]-20-[ContentDescription]-20-[ReadMoreView(50)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        contentView.addConstraints(verticalLabelConstraints)

        
        //Read More Button
        ReadMoreButton.ViewButtonColor = UIColor(netHex:0xB1E100)
        ReadMoreButton.ViewShadowColor = UIColor(netHex:0x78AC2D)
        ReadMoreButton.tag = self.ContentId as Int;
        ReadMoreButton.setTitle(self.buttonText, forState: UIControlState.Normal)
        ReadMoreButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        ReadMoreButton.titleLabel!.font =  UIFont (name: "Arial Rounded MT Bold", size: 17)
        ReadMoreButton.addTarget(self, action: "NavigateReadMore:", forControlEvents: UIControlEvents.TouchUpInside)
        ReadMoreButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        ReadMoreView.addSubview(ReadMoreButton)
        
        //Button Constraints
        let horizontalButtonConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[ReadMoreButton]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        ReadMoreView.addConstraints(horizontalButtonConstraints)
        let verticalButtonConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[ReadMoreButton]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        ReadMoreView.addConstraints(verticalButtonConstraints)
        
    }
    
    
    func NavigateReadMore(sender:CustomButton)
    {
        dispatch_async(dispatch_get_main_queue()) {
            
           self.firstAidViewDelegate.NavigateToDetails(self.ContentId)
        }
    }
    
}
