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
import Core
import RealmSwift
import RxSwift

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
            
            appModel!.menuItems.append(createMenuItem("Home", icon: "calendar", navigationId: "home"));
            appModel!.menuItems.append(createMenuItem("RxSearch", icon: "map", navigationId: "search"));
            appModel!.menuItems.append(createMenuItem("Login", icon: "news", navigationId: "login"));
            appModel!.menuItems.append(createMenuItem("Ad Example", icon: "photo", navigationId: "ads"));
            appModel!.menuItems.append(createMenuItem("Camera Example", icon: "comments", navigationId: "camera"));
            appModel!.menuItems.append(createMenuItem("Maps", icon: "tag", navigationId: "maps"));
            appModel!.menuItems.append(createMenuItem("Swipe Cards", icon: "wishlist", navigationId: "swipe"));
            appModel!.menuItems.append(createMenuItem("Payments", icon: "calendar", navigationId: "payments"));
            appModel!.menuItems.append(createMenuItem("Video", icon: "map", navigationId: "home"));
            appModel!.menuItems.append(createMenuItem("AWS Data", icon: "news", navigationId: "aws"));
            appModel!.menuItems.append(createMenuItem("Publishing", icon: "photo", navigationId: "publishing"));
        
            realm!.beginWrite()
            realm!.add(appModel!)
            try! realm!.commitWrite()
        }
        
        return true
    }
    
    private func createMenuItem(title: String, icon: String, navigationId: String) -> MenuItem {
        let item = MenuItem(title: title, icon: icon, navigationId: navigationId);
        save(item);
        return item;
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

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

