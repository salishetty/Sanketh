//
//  SplashViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 7/21/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //sleep added to simulate the check condition
        //TODO: check whether the user is logged in and redirect based on the logic
        sleep(3)
        //Redirect to login
        let  loggedin :Bool = false
        if(loggedin == false)
        {
        self.loadViewController("LogInView")
        }
        else
        {
        self.loadViewController("HomeView")
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
