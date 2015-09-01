//
//  StrategyListTableViewController.swift
//  Headzup
//
//  Created by Matt Solano on 8/7/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class StrategyListTableViewController: UITableViewController {
    
    //var strategiesArray = ["Strategy 1", "Strategy 2", "Strategy 3"]
    var dataMgr: DataManager?
    var strategiesArray:Array<Content> = []
    var selectedCategory : Category?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)

        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        
        if (selectedCategory != nil)
        {
            var theCategory = dataMgr?.getCategoryByID(selectedCategory!.categoryID as! Int)
            
            var theContent = dataMgr?.getContentByIDs(theCategory!.contentIDs)
            strategiesArray = theContent!
            //Sort by ContentName ASC
            strategiesArray.sort({$0.contentName < $1.contentName})
            //Set Title to name of category
            self.title = theCategory?.categoryName
        }
        else
        {
            let favorites:[ContentGroup] = dataMgr!.getFavoritedContents()!
            if favorites.count > 0
            {
                for favoriteItem in favorites
                {
                    var theContent = dataMgr?.getContentByID(favoriteItem.contentID as! Int)
                    strategiesArray.append(theContent!)
                }
            }
            //Sort by ContentName ASC
            strategiesArray.sort({$0.contentName < $1.contentName})
            self.title = "My Favorites"
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.strategiesArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("strategyCell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = self.strategiesArray[indexPath.row].contentName

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        var indexOfSelectedStrategy = 0
        if let cell = sender as? UITableViewCell {
            indexOfSelectedStrategy = tableView.indexPathForCell(cell)!.row
        }
        let detailsScreen = segue.destinationViewController as! StrategyDetailsViewController
        detailsScreen.selectedStrategy = (strategiesArray[indexOfSelectedStrategy] as Content)
        println("Selected Category:\(detailsScreen.selectedStrategy!.contentID)")
    }
    

}
