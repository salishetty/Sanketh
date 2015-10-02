//
//  TrackerReminderSettingViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/29/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import UIKit

class TrackerReminderSettingViewController: UIViewController {

    @IBOutlet weak var datePicker: CustomDatePicker!
    @IBOutlet weak var onOffSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let currentNotif = NotificationHelper.getNotification(NotificationConstants.TrackerName)
        {
           
            let currentDate = currentNotif.fireDate!
            datePicker.minimumDate = currentDate
            datePicker.date = currentDate
        }
        else
        {
            //enable tracker notification
            let date: NSDate = NSDate()
            let cal: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let fireDate: NSDate = cal.dateBySettingHour(8, minute: 0, second: 0, ofDate: date, options: NSCalendarOptions())!
            datePicker.minimumDate = fireDate
            datePicker.date = fireDate
            onOffSwitch.on = false
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

    @IBAction func SaveBT(sender: AnyObject) {
       
        if (onOffSwitch.on == true)
        {
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
        NotificationHelper.UpdateNotification(NotificationConstants.TrackerName, notifDate: alertTime, notifText: nil)
        }
        else
        {
            NotificationHelper.DisableNotification(NotificationConstants.TrackerName)
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
