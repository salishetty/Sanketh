//
//  GoalReminderSettingViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/29/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import UIKit

class GoalReminderSettingViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var OnOffswitch: UISwitch!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentDate = NSDate()
       
       if let currentNotif = NotificationHelper.getNotification(NotificationConstants.GoalName)
        {
            currentDate = currentNotif.fireDate!
            datePicker.minimumDate = currentDate
            datePicker.date = currentDate
        }
        else
        {
            OnOffswitch.on = false
            OnOffswitch.enabled = false
            saveButton.enabled = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Save(sender: AnyObject) {
        
        let selectedTime = datePicker.date
        let currentDate : NSDate = NSDate()
        let compareResult = currentDate.compare(currentDate)
        var alertTime:NSDate = selectedTime
        if compareResult == NSComparisonResult.OrderedAscending {
            alertTime = NSCalendar.currentCalendar().dateByAddingUnit(
                .Day,
                value: 1,
                toDate: selectedTime,
                options: NSCalendarOptions(rawValue: 0))!
            
        }
        
        //TODO: Get current goal text
        
        NotificationHelper.UpdateNotification(NotificationConstants.GoalName, notifDate: alertTime, notifText: nil)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
         return .LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
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
