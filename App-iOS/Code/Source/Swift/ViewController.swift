//
//  ViewController.swift
//  App-iOS
//
//  Copyright © 2015 Sky UK. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
    import RxSwift
#endif

#if os(iOS)
    import UIKit
    typealias OSViewController = UIViewController
    #elseif os(OSX)
    import Cocoa
    typealias OSViewController = NSViewController
#endif

class ViewController: OSViewController {
    #if TRACE_RESOURCES
    #if !RX_NO_MODULE
    private let startResourceCount = RxSwift.resourceCount
    #else
    private let startResourceCount = resourceCount
    #endif
    #endif
    
    override func viewDidLoad() {
        #if TRACE_RESOURCES
            print("Number of start resources = \(resourceCount)")
        #endif
    }
    
    deinit {
        #if TRACE_RESOURCES
            print("View controller disposed with \(resourceCount) resources")
            
            let numberOfResourcesThatShouldRemain = startResourceCount
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                assert(resourceCount <= numberOfResourcesThatShouldRemain, "Resources weren't cleaned properly")
            })
        #endif
    }
}
/*class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let core = CoreClass()
        core.coreStuff()
        core.coreStuffWithThirdPartyLibrary()
        core.coreStuffWithRxSwift()

        let sequence = sequenceOf(1, 2)
        _ = sequence.subscribe({ event in
            print("iOS app stuff with RxSwift: \(event)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}*/

