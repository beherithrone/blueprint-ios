//
//  AppDelegate.swift
//  App-iOS
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import TwitterKit
//import MoPub
import Core_iOS
import RealmSwift
import RxSwift
import AWSDynamoDB
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appModel : AppModel?
    var realm : Realm?;


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Dependencies.sharedDependencies.wireframe = DefaultWireframe()
        
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self, Twitter.self/*, MoPub.self*/])
        
        let core = CoreClass()
        core.coreStuff()
        core.coreStuffWithRxSwift()
        core.coreStuffWithThirdPartyLibrary()
        
        let sequence = sequenceOf(1, 2)
        _ = sequence.subscribe({ event in
            print("iOS app stuff with RxSwift: \(event)")
        })
        
        /*do {
            try NSFileManager.defaultManager().removeItemAtPath(Realm.Configuration.defaultConfiguration.path!)
        } catch {}*/
        
        //Get Realm
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let realmPath = documentsPath.stringByAppendingPathComponent("AppCache.realm")
        print("RealmPath: \(realmPath)")
        realm = try! Realm(path: realmPath)
        
        // Query
        let appModelArr = realm!.objects(AppModel)
        print("BUM before: \(appModelArr.count)")
        
        if(appModelArr.count > 0) {
            appModel!.menuItems = appModelArr[0].menuItems;
        }
        if ( appModel?.menuItems.count != 11) {
            // Save your object
            realm!.beginWrite()
            realm!.deleteAll();
            try! realm!.commitWrite()
            
            appModel!.populate()
            
            for item in appModel!.menuItems {
                save(item)
            }
        
            realm!.beginWrite()
            realm!.add(appModel!)
            try! realm!.commitWrite()
        }
        
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: AWSRegionType.USEast1, identityPoolId: "us-east-1:5af262d6-db1d-46c7-8a1e-d3d2c07e988e")
        
        let configuration = AWSServiceConfiguration(
            region: AWSRegionType.USEast1,
            credentialsProvider: credentialProvider)
        
        
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
        
        //Facebook
         //NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTokenUpdated:", name:FBSDKAccessTokenDidChangeNotification, object: nil)
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
        
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    private func save(item : MenuItem) -> Void {
        realm!.beginWrite()
        self.realm!.add(item)
        try! realm!.commitWrite()
    }

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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

