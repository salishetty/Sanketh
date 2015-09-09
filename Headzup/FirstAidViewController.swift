//
//  FirstAidViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 8/25/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class FirstAidViewController: UIViewController, UIScrollViewDelegate,FirstAidViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var pageControl: UIPageControl!
    
    var dataMgr: DataManager?
    
    var firstAidContents:Array<Int>= []
    
    var transferID:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ViewHelpers.setStatusBarTint(self.view)
        
        self.scrollView.delegate = self
        
        var size =  scrollView.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize)
        var contentwidth = scrollView.frame.size.width
        var screenWidth =  UIScreen.mainScreen().bounds.width
        var contentHeight = UIScreen.mainScreen().bounds.height * 0.745
        
        //Add call to update core data.
        
        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        self.firstAidContents = dataMgr!.getFirstAidContents()
        
        if self.firstAidContents.count > 0
        {
        self.scrollView.contentSize = CGSizeMake(CGFloat(self.firstAidContents.count) * screenWidth, contentHeight)
        pageControl.numberOfPages = self.firstAidContents.count
        
        
        var index:Int32 = 0
        for firstAidContent in self.firstAidContents
        {
            var theContent = dataMgr?.getContentByID(firstAidContent)
            var newFirstAid = FirstAidView(firstAid: theContent!)
            newFirstAid.firstAidViewDelegate = self
            var offset = (CGFloat(index) * newFirstAid.bounds.width)
            newFirstAid.frame.offset(dx: offset, dy: 0)
            
            self.scrollView.addSubview(newFirstAid)
            index++
        }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
