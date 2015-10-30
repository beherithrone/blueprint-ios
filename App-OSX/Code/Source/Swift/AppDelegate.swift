//
//  AppDelegate.swift
//  App-OSX
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import Cocoa
import Fabric
import Crashlytics
import Core

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        Fabric.with([Crashlytics.self])

    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        let core = CoreClass()
        core.coreStuff()
    }


}

