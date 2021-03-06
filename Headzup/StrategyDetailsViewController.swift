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
    
    @IBOutlet weak var multilineDescription: UILabel!
    @IBOutlet weak var MultiLineLabel: UILabel!
    @IBOutlet weak var audioButton: CustomButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var ContentViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var gapIMGLabel: NSLayoutConstraint!

    @IBOutlet weak var AudioViewHeight: NSLayoutConstraint!

    @IBOutlet weak var AudioViewBottonGap: NSLayoutConstraint!





    var dataMgr: DataManager?
    var strategiesArray:Array<Content> = []
    var selectedStrategy : Content?
    
    //Audio Player
    var audioPlayer: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewHelpers.setStatusBarTint(self.view)
        
        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        let theContent = dataMgr?.getContentByID(selectedStrategy!.contentID as Int)
        self.title = theContent?.contentName //"[Strategy Name]"
        self.multilineDescription.text = theContent?.contentDescription
        self.multilineDescription.numberOfLines = 0
        self.MultiLineLabel.text = theContent?.contentValue
        self.MultiLineLabel.numberOfLines = 0
        
        let heightPadding = ViewHelpers.heightForView(self.MultiLineLabel.text!, font: self.MultiLineLabel.font, width: self.MultiLineLabel.frame.width)
        
        ContentViewHeight.constant = heightPadding + self.view.frame.height
        
        
        
        //UserActionTracking - ViewStrategy
        self.dataMgr?.saveUserActionLog(UserActions.ViewStrategy, actionDateTime: NSDate(), contentID: "", comment: "ViewStrategy", isSynched: false)
        // Do any additional setup after loading the view.
        let theContentGroup = dataMgr?.getFavoritedContent(selectedStrategy!.contentID)
        
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
            addToFavorites.backgroundColor = UIColor(netHex:0x3B89E1)
            addToFavorites.addTarget(self, action: "AddToFavorites:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        //Content Image
        if let imagePath = theContent?.imagePath
        {
            if (!imagePath.isEmpty)
            {
                prepareToShow(imagePath)
            }
            else
            {
                let height: CGFloat = 0.0
                imageView.frame.size.height = height
                imageView.hidden = true
                gapIMGLabel.constant = 0
            }
        }
        else
        {
            let height: CGFloat = 0.0
            imageView.frame.size.height = height
            imageView.hidden = true
            gapIMGLabel.constant = 0
        }

        
        
        
        //Audio
        if let audioPath = theContent?.audioPath
        {
            if (!audioPath.isEmpty)
            {
            prepareToPlay(audioPath)
            }
            else
            {
                audioButton.hidden = true
                audioButton.superview?.hidden = true
                AudioViewHeight.constant = 0
                AudioViewBottonGap.constant = 0

            }
        }
        else
        {
            audioButton.hidden = true
            audioButton.superview?.hidden = true
            AudioViewHeight.constant = 0
            AudioViewBottonGap.constant = 0
        }
        contentView.sizeToFit()
        self.view.setNeedsLayout()
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
    
    func prepareToShow(filename:String)
    {
        imageView.frame.size.height = 150
        imageView.frame = CGRectMake(imageView.frame.origin.x ,imageView.frame.origin.y, imageView.frame.width, 150)
        imageView.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleWidth]
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        //: CGSize = imageView.frame.size
        imageView.image = ImageHelpers.resizeToHeight(UIImage(named:filename)!, height: 150)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    func prepareToPlay(filename:String)
    {
        let path = NSBundle.mainBundle().pathForResource(filename, ofType: "mp3")
        audioPlayer = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!))
        audioPlayer!.prepareToPlay()
        
    }
    
    @IBAction func AudioHandler(sender: CustomButton) {
        
        print("Clicked")
        if let player = audioPlayer {
          if (player.playing == false) {
                player.play()
                audioButton.setTitle("Pause", forState: UIControlState.Normal)
                audioButton.backgroundColor = UIColor.orangeColor()
                audioButton.ViewButtonColor = UIColor.orangeColor()
                audioButton.ViewShadowColor = UIColor.redColor()
                
            } else {
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
        let groupType = formatter.numberFromString(GroupType.Favorite)
        let todayDate = NSDate()
        dataMgr?.saveContentGroup(groupType!, dateModified: todayDate, contentID: selectedStrategy!.contentID, isActive: true)
        addToFavorites.removeTarget(self, action: "AddToFavorites:", forControlEvents: UIControlEvents.TouchUpInside)
        self.viewDidLoad()
    }
    
    func RemoveFavorites(sender:UIButton!) {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let groupType = formatter.numberFromString(GroupType.Favorite)
        let todayDate = NSDate()
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
