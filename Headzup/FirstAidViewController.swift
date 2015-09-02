//
//  FirstAidViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 8/25/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit

class FirstAidViewController: UIViewController, UIScrollViewDelegate {

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
    
    
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
