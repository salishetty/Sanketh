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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ViewHelpers.setStatusBarTint(self.view)
        
        self.scrollView.delegate = self
        
        var size =  scrollView.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize)
        var contentwidth = scrollView.frame.size.width
        var screenWidth =  UIScreen.mainScreen().bounds.width
        var contentHeight = UIScreen.mainScreen().bounds.height * 0.745
        
        
       self.scrollView.contentSize = CGSizeMake(7 * screenWidth, contentHeight)
        
        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        var firstAidContents = dataMgr?.getFirstAidContents()
        
        var index:Int32 = 0
        for firstAidContent in firstAidContents!
        {
            var theContent = dataMgr?.getContentByID(firstAidContent.toInt()!)
            var newFirstAid = FirstAidView(firstAid: theContent!)
            newFirstAid.firstAidViewDelegate = self
            var offset = (CGFloat(index) * newFirstAid.bounds.width)
            newFirstAid.frame.offset(dx: offset, dy: 0)
            
            self.scrollView.addSubview(newFirstAid)
            index++
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
    
    func NavigateToDetails(contentId:NSNumber) {
        
        self.performSegueWithIdentifier("FirstAidSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FirstAidSegue"{
            let vc = segue.destinationViewController as! FirstAidDetailsViewController
            vc.navigationItem.title = "Details"
            vc.ContentId = 1381
            navigationItem.title = "Back"
        }
    }
    

}
