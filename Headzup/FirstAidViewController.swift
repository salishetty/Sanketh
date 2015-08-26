//
//  FirstAidViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 8/25/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit

class FirstAidViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ViewHelpers.setStatusBarTint(self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
