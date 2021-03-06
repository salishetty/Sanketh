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
        let standardUserDefaults = NSUserDefaults.standardUserDefaults()
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
         
        AppContext.categories = dataMgr.getAllcategories()
        if ( AppContext.categories == nil || AppContext.categories?.count == 0) {
            
            
            dataMgr = DataManager(objContext: manObjContext)

            let serviceManager = ServiceManager()
            serviceManager.getContent { (jsonData) -> () in
                //Call ICMShelper to process the data
                ICMSHelper.processContent(jsonData, dataMgr: dataMgr)
            }
            AppContext.categories = dataMgr.getAllcategories()
        }
        let categoriesSaved = dataMgr.getMetaDataValue(MetaDataKeys.categoriesSaved)
        if categoriesSaved == "1"
        {
            dataMgr = DataManager(objContext: manObjContext)
            let serviceManager = ServiceManager()
            serviceManager.getTrackerContent({ (jsonData)->() in
                
                if let parseJSON = jsonData {
                    for contentIdJSON in parseJSON
                    {
                        print("Content IDs for Tracker \(contentIdJSON.1.intValue)")
                        let theContent = dataMgr.getContentByID(contentIdJSON.1.intValue)
                        AppContext.strategies.append([theContent!.contentID.stringValue, theContent!.contentName])
                    }
                }
            })
        }

        
        
    }
    func registerDefaultsFromSettingsBundle() {
        // this function writes default settings as settings
        let settingsBundle = NSBundle.mainBundle().pathForResource("Settings", ofType: "bundle")
        if settingsBundle == nil {
            NSLog("Could not find Settings.bundle");
            return
        }
        let settings = NSDictionary(contentsOfFile:(settingsBundle! as NSString).stringByAppendingPathComponent("Root.plist"))!
        let preferences: [NSDictionary] = settings.valueForKey("PreferenceSpecifiers") as! [NSDictionary];
        //let defaultsToRegister = NSMutableDictionary(capacity:(preferences.count));
        var defaultsToRegister: [String:AnyObject] = [:]
        
        for prefSpecification:NSDictionary in preferences {
            let key: String? = prefSpecification.objectForKey("Key") as! String?
            if key != nil {
                //defaultsToRegister.setObject(prefSpecification.objectForKey("DefaultValue")!, forKey: key!)
                defaultsToRegister[key!] = prefSpecification.valueForKey("DefaultValue")
            }
        }
        NSUserDefaults.standardUserDefaults().registerDefaults(defaultsToRegister);
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        ContextManager.initialize(self.managedObjectContext!)
        appInit()
        
        NotificationHelper.SetupTrackerNotification(application)
        NotificationHelper.SetupGoalNotification(application)
        
        
        //Navigation Bar - Important
        // Sets background to a blank/empty image and set alpha to 0
        UINavigationBar.appearance().barStyle = .Black
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = UIColor(hex:0x5DB8EB,alpha:1)
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor() //UIColor(hex:0x5DB8EB,alpha:1)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : UIFont(name: "Arial Rounded MT Bold", size: 17)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().clipsToBounds = true
               
        //App Launched from Notification
        application.applicationIconBadgeNumber = 0
        let notification = launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey] as! UILocalNotification!
        if (notification != nil) {
            NotificationHelper.notificationRedirect(notification)
        }
        return true
    }
    
    
    
    //Notification Section
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        application.applicationIconBadgeNumber = 0
        
       // println("application state:\(application.applicationState.rawValue)")
        
        if ( application.applicationState == UIApplicationState.Inactive || application.applicationState == UIApplicationState.Background  )
        {
           NotificationHelper.notificationRedirect(notification)
        }
        
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        application.applicationIconBadgeNumber = 0
        NotificationHelper.notificationRedirect(notification)
                
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
        
        let status = AppContext.loginStatus
        switch status {
        case LoginStatus.LoggedOut :
            print ("user has logged out")
        case LoginStatus.LoggedIn :
            print ("user has logged in")
        default :
            AppContext.loginStatus = LoginStatus.NeverLoggedIn
            print ("user has never logged in")
            // go to home page directly
            
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        let userDisabled = LogInHelper.isDisabled()
        if (userDisabled == true)
        {
            let rootViewController = self.window!.rootViewController
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let setViewController = mainStoryboard.instantiateViewControllerWithIdentifier("PinView") as! PinViewController
            rootViewController!.navigationController!.popToViewController(setViewController, animated: false)
        }
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
        return urls[urls.count-1] 
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
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch var error1 as NSError {
            error = error1
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
        } catch {
            fatalError()
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
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error1 as NSError {
                    error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }
    
}

