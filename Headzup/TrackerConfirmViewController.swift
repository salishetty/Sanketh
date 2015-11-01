//
//  TrackerConfirmViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 10/8/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class TrackerConfirmViewController: UIViewController {

    internal var selectedDate : NSDate?
    var dataMgr: DataManager?
    @IBOutlet weak var ConfirmLabel: UILabel!

     override func viewDidLoad() {
        super.viewDidLoad()

        // init data
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .NoStyle
        let dateString = formatter.stringFromDate(selectedDate!)
        AppContext.trackDate = selectedDate
        //Reset the values of painRaesons and Effectiveness comma separated values to empty strings
        AppContext.painReasonsResponseValue = ""
        AppContext.EffectivenessResponseValue = ""
        
        let isToday = NSCalendar.currentCalendar().isDateInToday(selectedDate!)
        let  isYesterday =  NSCalendar.currentCalendar().isDateInYesterday(selectedDate!)
        if (isToday)
        {
            ConfirmLabel.text = "Have you had a headache today, \(dateString)?"

        }
        else if (isYesterday)
        {
            ConfirmLabel.text = "Have you had a headache yesterday, \(dateString)?"
        }
        else
        {
            ConfirmLabel.text = "Have you had a headache on, \(dateString)?"
            
        }

}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func YesButton(sender: AnyObject) {

        let isToday = NSCalendar.currentCalendar().isDateInToday(selectedDate!)
        let  isYesterday =  NSCalendar.currentCalendar().isDateInYesterday(selectedDate!)
        AppContext.InitialResponseTracker = "Yes"
        
        if (isToday)
        {
            print("selected Date:\(selectedDate)")
        }
        else if (isYesterday)
        {
            print("selected Date:\(selectedDate)")
        }
        else
        {

        }

        
    }

    @IBAction func NoButton(sender: AnyObject) {

        let isToday = NSCalendar.currentCalendar().isDateInToday(selectedDate!)
        let  isYesterday =  NSCalendar.currentCalendar().isDateInYesterday(selectedDate!)
        AppContext.InitialResponseTracker = "No"
        if (isToday)
        {
        }
        else if (isYesterday)
        {

        }
        else
        {
    
        }


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
