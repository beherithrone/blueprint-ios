//
//  Wireframe.swift
//  App-iOS
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import Foundation
import UIKit
import Core_iOS

class DefaultWireframe: Wireframe {
    func openURL(URL: NSURL) {
        UIApplication.sharedApplication().openURL(URL)
    }
}