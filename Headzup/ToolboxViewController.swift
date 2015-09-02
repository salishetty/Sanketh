//
//  ToolboxViewController.swift
//  Headzup
//
//  Created by Matt Solano on 8/4/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class ToolboxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoritesArray = ["My Favorites"]
    
    var categoriesArray:Array<Category> = []
    var dataMgr: DataManager?  // initialized in viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewHelpers.setStatusBarTint(self.view)
        // Get Categories from Category object in CoreData
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "Category")
        categoriesArray = manObjContext.executeFetchRequest(fetchRequest, error: nil) as! Array<Category>!
        //Sort by categoryName ASC
        categoriesArray.sort({$0.categoryName < $1.categoryName})
        // ---------------------------------
        println("Categories=\(categoriesArray.count)")

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
        if(tableView == self.categoryTableView)
        {
            return self.categoriesArray.count
            
        }
        else
        {
            return self.favoritesArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(tableView == self.categoryTableView)
        {
            var cell:UITableViewCell = self.categoryTableView.dequeueReusableCellWithIdentifier("categoryCell") as! UITableViewCell
            
            cell.textLabel?.text = self.categoriesArray[indexPath.row].categoryName
            
            return cell
        }
        else
        {
   
            
            var cell:UITableViewCell = self.favoriteTableView.dequeueReusableCellWithIdentifier("favoriteCell") as! UITableViewCell
            
            cell.textLabel?.text = self.favoritesArray[indexPath.row]// self.categoriesArray[indexPath.row].categoryName
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "categoriesInfo"
        {
            // Get the new view controller using segue.destinationViewController.
            //Get the index of selected row
            var indexOfSelectedCategory = 0
            if let cell = sender as? UITableViewCell {
                indexOfSelectedCategory = categoryTableView.indexPathForCell(cell)!.row
            }
            // Pass the selected object to the new view controller.
            let detailsScreen = segue.destinationViewController as! StrategyListTableViewController
            detailsScreen.selectedCategory = (categoriesArray[indexOfSelectedCategory] as Category)
            println("Selected Category:\(detailsScreen.selectedCategory?.categoryID)")
        }
    }
    

}
