//
//  FirstAidViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 8/25/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit

class FirstAidViewController: UIViewController, UIScrollViewDelegate,FirstAidViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var pageControl: UIPageControl!
    
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
        
        for index in 0...6 {
            var newFirstAid = FirstAidView()
            newFirstAid.firstAidViewDelegate = self
            var offset = (CGFloat(index) * newFirstAid.bounds.width)
            newFirstAid.frame.offset(dx: offset, dy: 0)
            
            self.scrollView.addSubview(newFirstAid)
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
            navigationItem.title = "First Aid"
        }
    }
    

}
