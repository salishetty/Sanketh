//
//  AppDelegate.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/14/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func appInit() {
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        var dataMgr = DataManager(objContext: manObjContext)
        var env = ""
        var standardUserDefaults = NSUserDefaults.standardUserDefaults()
        var us: AnyObject? = standardUserDefaults.objectForKey("st_env")
        if us == nil {
            self.registerDefaultsFromSettingsBundle();
            us = standardUserDefaults.objectForKey("st_env")
        }
        env = us as! String
        
        // check env
        AppContext.svcUrl = dataMgr.getMetaDataValue(MetaDataKeys.SvcUrl)
        if AppContext.svcUrl != "" && AppContext.svcUrl != env {
            dataMgr.deleteAllData("MetaData")
        }
        dataMgr.saveMetaData(MetaDataKeys.SvcUrl, value: env, isSecured: false)
        AppContext.svcUrl = env
        
        // Set login Status from Database
        AppContext.loginStatus = dataMgr.getMetaDataValue(MetaDataKeys.LoginStatus)
        
        
        AppContext.categories = dataMgr.getAllcategories()
        if ( AppContext.categories == nil || AppContext.categories?.count == 0) {
            //Save Content and Category to CoreData - To be replaced later by data coming from Headzup Service
            
            dataMgr.saveContentCategory(1, categoryName: "View all", contentIDs: "101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115")
            dataMgr.saveContentCategory(2, categoryName: "Communicating about your pain", contentIDs: "104, 105, 103, 111")
            dataMgr.saveContentCategory(3, categoryName: "Eating better", contentIDs: "106, 107, 109, 112")
            dataMgr.saveContentCategory(4, categoryName: "Getting more active", contentIDs: "108, 109, 102, 113")
            dataMgr.saveContentCategory(5, categoryName: "Managing your time", contentIDs: "110, 101, 108, 114")
            dataMgr.saveContentCategory(6, categoryName: "Relaxing", contentIDs: "103, 105, 107, 115")
            dataMgr.saveContentCategory(7, categoryName: "Sleeping better", contentIDs: "103, 105, 107, 109")
            //Save Content to CoreData
            dataMgr.saveContent(101, contentName: "30 x 3 = Fewer Headaches", contentDescription: "", contentValue: "Research is showing that regular exercise can help reduce the frequency of headaches. Just start a new exercise plan slowly.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(102, contentName: "App-propriate Help for Headaches", contentDescription: "", contentValue: "In our approach to dealing with headaches, we recommend taking breaks from screen time. And while we don’t want to sound hypocritical, there are times when your phone can actually help.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(103, contentName: "Don’t Skip Breakfast", contentDescription: "", contentValue: "This is pretty straightforward. If you’re skipping breakfast regularly, you’re not alone -about 36% of teens skip breakfast.  How does breakfast impact my headaches? We’re glad you asked.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(104, contentName: "Give Yourself A Break", contentDescription: "", contentValue: "We all have days where we have a lot to get done, whether it’s a big project for school or studying for tests. One key to getting a lot done is to take breaks.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(105, contentName: "Knowledge is Power", contentDescription: "", contentValue: "You might be tired of hearing that your headaches could be linked to your period and hormone changes. We’re really sorry, but our research shows that for about 50% of women with migraines, their menstrual cycle plays a role, maybe because estrogen levels dip during menstruation.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(106, contentName: "One Step at a Time", contentDescription: "", contentValue: "Deciding to get more exercise is one thing. Building a routine can be quite another. Start slow and get prepped.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(107, contentName: "Pain Hits the Road", contentDescription: "", contentValue: "While headaches might feel like they're ruling (and even ruining) your life at times, you can take charge. Try meditation. Reducing stress=Fewer headaches.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(108, contentName: "Screens Off", contentDescription: "", contentValue: "More and more  teens are falling asleep with TV or other electronic equipment going on in the background. Maybe you think that having a TV show playing quietly will distract your busy mind, but study after study shows just the opposite.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(109, contentName: "Scents-able Sleep", contentDescription: "", contentValue: "Ever have one of those nights when you’re studying hard for a test and then try to go right to sleep because it’s so late? Or maybe your brain just tends to spin away at bedtime most nights. Help yourself wind down with an essential oil like lavender.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(110, contentName: "Sink or Swim?", contentDescription: "", contentValue: "Guided imagery gives you the chance to use your  imagination to help you relax. It can be a really powerful tool in reducing stress and anxiety. It’s also a distraction from pain.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(111, contentName: "Sleeping in the Dark", contentDescription: "", contentValue: "Sleeping in a dark room sounds pretty obvious. But before you go to bed tonight, turn out the light and look around your room.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(112, contentName: "Sleep Journal", contentDescription: "", contentValue: "School starts early. You might feel like a night owl. But getting consistent rest can help cut down the number of headaches you get. ", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(113, contentName: "Spike Your Water", contentDescription: "", contentValue: "Adding fresh herbs is a great way to give your water a burst of flavor. Check out our suggestions for a tasty way to boost the health benefits of hydration. Keep a nice, cool pitcher of water in the fridge or add herbs to your water bottle.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(114, contentName: "Time and Timer Again", contentDescription: "", contentValue: "Here’s another good way to break up big projects and not go crazy in the process. Use a timer.", contentType: "", imagePath: "", audioPath: "")
            dataMgr.saveContent(115, contentName: "Update Your Water (H20 2.0)", contentDescription: "", contentValue: "Water is…well, it’s pretty plain. It’s good for you, but that doesn’t make it exciting. Try some of these suggestions to give your H20 a boost.", contentType: "", imagePath: "", audioPath: "")
            
            AppContext.categories = dataMgr.getAllcategories()
        }
    }
    func registerDefaultsFromSettingsBundle() {
        // this function writes default settings as settings
        var settingsBundle = NSBundle.mainBundle().pathForResource("Settings", ofType: "bundle")
        if settingsBundle == nil {
            NSLog("Could not find Settings.bundle");
            return
        }
        var settings = NSDictionary(contentsOfFile:settingsBundle!.stringByAppendingPathComponent("Root.plist"))!
        var preferences: [NSDictionary] = settings.objectForKey("PreferenceSpecifiers") as! [NSDictionary];
        var defaultsToRegister = NSMutableDictionary(capacity:(preferences.count));
        
        for prefSpecification:NSDictionary in preferences {
            var key: NSCopying? = prefSpecification.objectForKey("Key") as! NSCopying?
            if key != nil {
                defaultsToRegister.setObject(prefSpecification.objectForKey("DefaultValue")!, forKey: key!)
            }
        }
        NSUserDefaults.standardUserDefaults().registerDefaults(defaultsToRegister as [NSObject : AnyObject]);
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        appInit()
        
        NotificationHelper.SetupTrackerNotification(application)
        NotificationHelper.SetupGoalNotification(application)
        
        //App Launched from Notification
        let notification = launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey] as! UILocalNotification!
        if (notification != nil) {
            if notification.category == NotificationConstants.GoalCategory {
                AppContext.currentView = "GoalView"
            }
        }
        return true
    }
    
    //Notification Section
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        application.applicationIconBadgeNumber = 0
        if ( application.applicationState == UIApplicationState.Inactive || application.applicationState == UIApplicationState.Background  )
        {
            //opened from a local notification when the app was on background
            
            if notification.category! == NotificationConstants.GoalCategory {
                AppContext.currentView = "GoalView"
            }
            if notification.category == NotificationConstants.TrackerCategory {
                AppContext.currentView = "GoalView"
            }
        }
        
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        switch (identifier!) {
        case NotificationConstants.GoalComplete:
            println("Error: unexpected notification action identifier!")
        case NotificationConstants.TrackerComplete:
            println("Error: unexpected notification action identifier!")
        default: // switch statements must be exhaustive - this condition should never be met
            println("Error: unexpected notification action identifier!")
        }
        completionHandler() // per developer documentation, app will terminate if we fail to call this
    }
    
    //Notification Section Ends
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        appInit()
        
        var status = AppContext.loginStatus
        switch status {
        case LoginStatus.LoggedOut :
            println ("user has logged out")
        case LoginStatus.LoggedIn :
            println ("user has logged in")
        default :
            AppContext.loginStatus = LoginStatus.NeverLoggedIn
            println ("user has never logged in")
            // go to home page directly
            
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.inflexxion.Headzup" in the application's documents Application Support directory.
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        NSLog("\(paths[0])")
        
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Headzup", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Headzup.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }
    
}

