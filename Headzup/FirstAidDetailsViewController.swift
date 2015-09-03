//
//  FirstAidDetailsViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/2/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class FirstAidDetailsViewController: UIViewController {

    internal var ContentId:NSNumber = 0
    
    @IBOutlet weak var imageView: UIImageView!
  
    @IBOutlet weak var MultiLineLabel: UILabel!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var ContentViewHeigth: NSLayoutConstraint!
    
    var dataMgr: DataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewHelpers.setStatusBarTint(self.view)
        println("Details View Content ID\(ContentId)")
        
        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        var theContent = dataMgr?.getContentByID(ContentId as! Int)
        self.title = theContent?.contentName
        
        self.MultiLineLabel.text = theContent?.contentValue
        self.MultiLineLabel.numberOfLines = 0
        
        var heightPadding = ViewHelpers.heightForView(self.MultiLineLabel.text!, font: self.MultiLineLabel.font, width: self.MultiLineLabel.frame.width)
        ContentViewHeigth.constant = heightPadding + self.view.frame.height
        
        //Content Image
        if let imagePath = theContent?.imagePath
        {
            if (!imagePath.isEmpty)
            {
                prepareToShow(imagePath)
            }
            else
            {
                let height: CGFloat = 0.0
                imageView.frame.size.height = height
                imageView.hidden = true
            }
        }
        else
        {
            let height: CGFloat = 0.0
            imageView.frame.size.height = height
            imageView.hidden = true
        }

        
        
        self.view.setNeedsLayout()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareToShow(filename:String)
    {
        imageView.frame.size.height = 75
        imageView.frame = CGRectMake(imageView.frame.origin.x ,imageView.frame.origin.y, imageView.frame.width, 75)
        imageView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        
        let size: CGSize = imageView.frame.size
        imageView.image = ImageHelpers.resizeToHeight(UIImage(named:filename)!, height: 75.0)
        
    }

    
    @IBAction func willTryButton(sender: CustomButton) {
        println("willtryButton")
    }
  
    @IBAction func removeThis(sender: CustomButton) {
        println("removeThis")

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
