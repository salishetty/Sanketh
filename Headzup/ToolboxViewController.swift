//
//  ToolboxViewController.swift
//  Headzup
//
//  Created by Matt Solano on 8/4/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit

class ToolboxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categoriesArray = ["View all", "Communicating about your pain", "Eating better", "Getting more active", "Managing your time", "Relaxing", "Sleeping better"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoriesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.categoryTableView.dequeueReusableCellWithIdentifier("categoryCell") as! UITableViewCell
        
        cell.textLabel?.text = self.categoriesArray[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
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
