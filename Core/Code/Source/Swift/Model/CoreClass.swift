//
//  CoreClass.swift
//  Core
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import Foundation

import RxSwift

public class CoreClass {
    public init() {

    }

    public func coreStuff() -> Int {
        print("Core stuff")
        return 1
    }

    public func coreStuffWithThirdPartyLibrary() {
        //print("Core stuff with third party library (Alamofire): \(Manager.defaultHTTPHeaders)")
    }

    public func coreStuffWithRxSwift() {
        let sequence = sequenceOf(1, 2)
        _ = sequence.subscribe({ event in
            print("Core stuff with RxSwift: \(event)")
        })
    }
}
