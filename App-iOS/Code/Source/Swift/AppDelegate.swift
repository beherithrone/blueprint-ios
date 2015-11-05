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

class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
}

class Person: Object {
    dynamic var name = ""
    let dogs = List<Dog>()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appModel : AppModel?


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
        
        
        
        do {
            try NSFileManager.defaultManager().removeItemAtPath(Realm.Configuration.defaultConfiguration.path!)
        } catch {}
        
        // Create a standalone object
        let mydog = Dog()
        
        // Set & read properties
        mydog.name = "Rex"
        mydog.age = 9
        print("Name of dog: \(mydog.name)")
        
        // Realms are used to group data together
        let realm = try! Realm() // Create realm pointing to default file
        
        // Save your object
        realm.beginWrite()
        realm.add(mydog)
        try! realm.commitWrite()
        
        // Query
        let results = realm.objects(Dog).filter(NSPredicate(format:"name contains 'x'"))
        
        // Queries are chainable!
        let results2 = results.filter("age > 8")
        print("Number of dogs: \(results.count)")
        print("Dogs older than eight: \(results2.count)")
        
        // Link objects
        let person = Person()
        person.name = "Tim"
        person.dogs.append(mydog)
        
        try! realm.write {
            realm.add(person)
        }
        
        // Multi-threading
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let otherRealm = try! Realm()
            let otherResults = otherRealm.objects(Dog).filter(NSPredicate(format:"name contains 'Rex'"))
            print("Number of dogs \(otherResults.count)")
        }
        
        return true
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

