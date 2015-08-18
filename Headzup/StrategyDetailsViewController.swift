//
//  StrategyDetailsViewController.swift
//  Headzup
//
//  Created by Matt Solano on 8/7/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class StrategyDetailsViewController: UIViewController{
    
    @IBOutlet weak var MultiLineLabel: UILabel!
    @IBOutlet weak var audioButton: CustomButton!
    
    var dataMgr: DataManager?
    var strategiesArray:Array<Content> = []
    var selectedStrategy : Content?
    
    //Audio Player
    var audioPlayer: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        var theContent = dataMgr?.getContentByID(selectedStrategy!.contentID as! Int)
        self.title = theContent?.contentName //"[Strategy Name]"
        
        self.MultiLineLabel.text = theContent?.contentValue
        self.MultiLineLabel.numberOfLines = 0
        
        
        //UserActionTracking - ViewStrategy
        self.dataMgr?.saveUserActionLog(UserActions.ViewStrategy, actionDateTime: NSDate(), contentID: "", comment: "ViewStrategy", isSynched: false)
        // Do any additional setup after loading the view.
        var theContentGroup = dataMgr?.getContentGroup(selectedStrategy!.contentID)
        
        if (theContentGroup?.isActive == 1)
        {
            addToFavorites.setTitle("Remove from Favorites", forState: UIControlState.Normal)
            addToFavorites.backgroundColor = UIColor.orangeColor()
            addToFavorites.superview?.layer.shadowColor = UIColor.redColor().CGColor
            addToFavorites.superview?.reloadInputViews()
            addToFavorites.addTarget(self, action: "RemoveFavorites:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        else
        {
            addToFavorites.setTitle("Add to Favorites", forState: UIControlState.Normal)
            addToFavorites.addTarget(self, action: "AddToFavorites:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        //Remove this after testing
        theContent?.audioPath = "DemoAudio"
        
        if let audioPath = theContent?.audioPath
        {
            prepareToPlay(audioPath)
        }
        
        /*let url = theContent?.audioPath
        let playerItem = AVPlayerItem( URL:NSURL( string:url! ) )
        audioPlayer = AVPlayer(playerItem:playerItem)
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var addToFavorites: UIButton!
    /*@IBAction func AddToFavorites(sender: UIButton) {
    }*/
    
    
    @IBAction func SetAsGoal(sender: UIButton) {
    }
    
    
    func prepareToPlay(filename:String)
    {
        var path = NSBundle.mainBundle().pathForResource(filename, ofType: "mp3")
        audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!), error: nil)
        audioPlayer!.rate = 0.0
        audioPlayer!.prepareToPlay()
        
    }
    
    
    
    @IBAction func AudioHandler(sender: CustomButton) {
        
        println("Clicked")
        if let player = audioPlayer {
            if player.rate == 0.0 {
                player.rate = 1.0;
                player.play()
                audioButton.setTitle("Pause", forState: UIControlState.Normal)
                audioButton.backgroundColor = UIColor.orangeColor()
                audioButton.ViewButtonColor = UIColor.orangeColor()
                audioButton.ViewShadowColor = UIColor.redColor()
                
            } else {
                player.rate = 0.0;
                player.pause()
                audioButton.setTitle("Play", forState: UIControlState.Normal)
                audioButton.backgroundColor = UIColor(netHex:0x6B930C)
                audioButton.ViewButtonColor = UIColor(netHex:0x6B930C)
                audioButton.ViewShadowColor = UIColor(netHex:0x486308)
            
            }
            
        }
        
    }
    
    func AddToFavorites(sender:UIButton!) {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        var groupType = formatter.numberFromString(GroupType.Favorite)
        var todayDate = NSDate()
        dataMgr?.saveContentGroup(groupType!, dateModified: todayDate, contentID: selectedStrategy!.contentID, isActive: true)
        addToFavorites.removeTarget(self, action: "AddToFavorites:", forControlEvents: UIControlEvents.TouchUpInside)
        self.viewDidLoad()
    }
    
    func RemoveFavorites(sender:UIButton!) {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        var groupType = formatter.numberFromString(GroupType.Favorite)
        var todayDate = NSDate()
        dataMgr?.saveContentGroup(groupType!, dateModified: todayDate, contentID: selectedStrategy!.contentID, isActive: false)
        addToFavorites.removeTarget(self, action: "RemoveFavorites:", forControlEvents: UIControlEvents.TouchUpInside)
        self.viewDidLoad()
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
