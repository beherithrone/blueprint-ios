//
//  ViewController.swift
//  Atlas-macOS
//
//  Copyright © 2015 Sky UK. All rights reserved.
//

import Cocoa

import Core
import RxSwift

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let core = CoreClass()
        core.coreStuff()
        core.coreStuffWithThirdPartyLibrary()
        core.coreStuffWithRxSwift()

        let sequence = sequenceOf(1, 2)
        _ = sequence.subscribe({ event in
            print("macOS app stuff with RxSwift: \(event)")
        })
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

