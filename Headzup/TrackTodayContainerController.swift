//
//  TrackTodayContainerController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 10/29/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import UIKit

class TrackTodayContainerController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let selectedDate = AppContext.trackDate
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .NoStyle
        let dateString = formatter.stringFromDate(selectedDate!)

        let isToday = NSCalendar.currentCalendar().isDateInToday(selectedDate!)
        let  isYesterday =  NSCalendar.currentCalendar().isDateInYesterday(selectedDate!)
        if (isToday)
        {
             navBar.topItem?.title = "Track for Today"

        }
        else if (isYesterday)
        {
           navBar.topItem?.title = "Track for Yesterday"
        }
        else
        {
            navBar.topItem?.title = "Track For \(dateString)"
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    

}
