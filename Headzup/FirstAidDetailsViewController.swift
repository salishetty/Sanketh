//
//  FirstAidDetailsViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/2/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class FirstAidDetailsViewController: UIViewController {

    internal var ContentId:NSNumber = 0
    
    @IBOutlet weak var imageView: UIImageView!
  
    @IBOutlet weak var MultiLineLabel: UILabel!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var ContentViewHeigth: NSLayoutConstraint!
    
    @IBOutlet weak var audioButton: CustomButton!
    @IBOutlet weak var imageViewHeigth: NSLayoutConstraint!
    @IBOutlet weak var audioViewHeigth: NSLayoutConstraint!
    
    var dataMgr: DataManager?

    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewHelpers.setStatusBarTint(self.view)
        println("Details View Content ID\(ContentId)")
        
        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        var theContent = dataMgr?.getContentByID(ContentId as! Int)
        self.title = theContent?.contentName
        
        self.MultiLineLabel.text = theContent?.contentValue
        self.MultiLineLabel.numberOfLines = 0
        
        var heightPadding = ViewHelpers.heightForView(self.MultiLineLabel.text!, font: self.MultiLineLabel.font, width: self.MultiLineLabel.frame.width)
        ContentViewHeigth.constant = heightPadding + self.view.frame.height
        
        //Content Image
        imageViewHeigth.constant = 0
        if let imagePath = theContent?.imagePath
        {
            if (!imagePath.isEmpty)
            {
                imageViewHeigth.constant = 75
                prepareToShow(imagePath)
            }
        }

        //Audio
        audioViewHeigth.constant = 0
        audioButton.hidden = true
        if let audioPath = theContent?.audioPath
        {
            if (!audioPath.isEmpty)
            {
                audioButton.hidden = false
                prepareToPlay(audioPath)
            }
        }
        
        self.view.setNeedsLayout()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareToShow(filename:String)
    {
        let trimmedFileName:String = filename.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        imageView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = ImageHelpers.resizeToHeight(UIImage(named: trimmedFileName)!,height: 75.0)
        
    }

    func prepareToPlay(filename:String)
    {
        audioViewHeigth.constant = 50
        var path = NSBundle.mainBundle().pathForResource(filename, ofType: "mp3")
        audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!), error: nil)
        audioPlayer!.prepareToPlay()
        
    }

    @IBAction func PlayNow(sender: AnyObject) {
        if let player = audioPlayer {
            if (player.playing == false) {
                player.play()
                audioButton.setTitle("Pause", forState: UIControlState.Normal)
                audioButton.backgroundColor = UIColor(netHex:0xF6771A)
                audioButton.ViewButtonColor = UIColor(netHex:0xF6771A)
                audioButton.ViewShadowColor = UIColor(netHex:0xC23D02)
                
            } else {
                player.pause()
                audioButton.setTitle("Play Now", forState: UIControlState.Normal)
                audioButton.backgroundColor = UIColor(netHex:0xB1E100)
                audioButton.ViewButtonColor = UIColor(netHex:0xB1E100)
                audioButton.ViewShadowColor = UIColor(netHex:0x78AC2D)
                
            }
            
        }

    }
    
    @IBAction func willTryButton(sender: CustomButton) {
        println("willtryButton")
    }
  
    @IBAction func removeThis(sender: CustomButton) {
        println("removeThis")

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
