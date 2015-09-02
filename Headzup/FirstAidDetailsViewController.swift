//
//  FirstAidDetailsViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/2/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit

class FirstAidDetailsViewController: UIViewController {

    internal var ContentId:NSNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("Details View Content ID\(ContentId)")
        // Do any additional setup after loading the view.
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
