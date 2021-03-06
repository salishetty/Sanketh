//
//  FirstAidViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 8/25/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON
class FirstAidViewController: UIViewController, UIScrollViewDelegate,FirstAidViewDelegate,UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var pageControl: UIPageControl!

    var dataMgr: DataManager?
    var firstAidContents:Array<Int>= []

    var transferID:Int = 0

    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        ViewHelpers.setStatusBarTint(self.view)

        self.scrollView.delegate = self

        //        var size =  scrollView.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize)
        //        var contentwidth = scrollView.frame.size.width
        let screenWidth =  UIScreen.mainScreen().bounds.width
        let contentHeight = UIScreen.mainScreen().bounds.height * 0.745

        //Add call to update core data.

        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        //If there is network connectivity - Get FirstAid Contents and add/update the contents in ContentGroup
        print("Starting time:\(NSDate())")
        
        if AppContext.hasConnectivity()
        {
            let serviceManager = ServiceManager()
            serviceManager.getFirstAidContent({ (jsonData: JSON?)->() in
                //Declare array of ContentIDs which are of Intervention Type

                if let parseJSON = jsonData {
                    for contentIdJSON in parseJSON
                    {
                        print("Recieved time:\(NSDate())")
                        print("Conetent id for firstaid \(contentIdJSON.1.intValue)")
                        let formatter = NSNumberFormatter()
                        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
                        let groupType = formatter.numberFromString(GroupType.OMG)
                        self.dataMgr!.saveContentGroup(groupType!, dateModified: NSDate(), contentID: contentIdJSON.1.intValue, isActive: false)
                        print("Saved time:\(NSDate())")
                    }

                }
            })
        }
        print("Starting sleep:\(NSDate())")
        sleep(2)
        print("Wakeup time:\(NSDate())")
        self.firstAidContents = dataMgr!.getFirstAidContents()

        if self.firstAidContents.count > 0
        {
            self.scrollView.contentSize = CGSizeMake(CGFloat(self.firstAidContents.count) * screenWidth, contentHeight)
            pageControl.numberOfPages = self.firstAidContents.count


            var index:Int32 = 0
            for firstAidContent in self.firstAidContents
            {
                let theContent = dataMgr?.getContentByID(firstAidContent)
                let newFirstAid = FirstAidView(firstAid: theContent!)
                newFirstAid.firstAidViewDelegate = self
                let offset = (CGFloat(index) * newFirstAid.bounds.width)
                newFirstAid.frame.offsetInPlace(dx: offset, dy: 0)

                self.scrollView.addSubview(newFirstAid)
                index++
            }
        }

        showOverLay()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func showOverLay()
    {
        overlayView = UIView(frame: UIScreen.mainScreen().bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)

        let imageName = "SwipeHelp"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = UIScreen.mainScreen().bounds //CGRectMake(50, 300, 300, 250)
        overlayView.addSubview(imageView)

        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        tapGesture.delegate = self
        overlayView.addGestureRecognizer(tapGesture)
        view.addSubview(overlayView)
    }

    func handleTap(sender: UITapGestureRecognizer) {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {

        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        pageControl.currentPage = page
    }

    func NavigateToDetails(contentId:Int) {
        self.transferID = contentId
        self.performSegueWithIdentifier("FirstAidSegue", sender: self)

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FirstAidSegue"{
            let vc = segue.destinationViewController as! FirstAidDetailsViewController
            vc.ContentId = self.transferID
        }
    }
    
    @IBAction func closeFirstAidDetails(segue:UIStoryboardSegue)
    {
        
    }
    
    
}
