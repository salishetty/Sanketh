//
//  TrackerTodayFinalViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 10/21/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import UIKit

class TrackerTodayFinalViewController: UIViewController {

  
    @IBOutlet weak var navBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func DoneBN(sender: UIButton) {
        //navigate back to Tracker tab
        self.loadViewController("TabView",tabIndex:2)
    }

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    private var embededTableViewController:EffectivenessTableViewController!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destinationViewController as? EffectivenessTableViewController
            where segue.identifier == "EffectivenessEmbededSegue"
        {
            self.embededTableViewController = vc
        }
    }



}
