//
//  GoalReminderSettingViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/29/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import UIKit

class GoalReminderSettingViewController: UIViewController {

    @IBOutlet weak var DatePicker: UIDatePicker!
    
    @IBOutlet weak var Switch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DatePicker.backgroundColor = UIColor(hex:0x5DB8EB,alpha:1)
//        DatePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Save(sender: AnyObject) {
        
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
