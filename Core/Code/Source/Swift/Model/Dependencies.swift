//
//  Dependencies.swift
//  App-iOS
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import Foundation
import RxSwift

public class Dependencies {
    
    public static let sharedDependencies = Dependencies() // Singleton
    
    public let URLSession = NSURLSession.sharedSession()
    public let backgroundWorkScheduler: ImmediateSchedulerType
    public let mainScheduler: SerialDispatchQueueScheduler
    public var wireframe: Wireframe?
    
    private init() {
        //wireframe = DefaultWireframe()
        
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        if #available(OSX 10.10, *) {
            operationQueue.qualityOfService = NSQualityOfService.UserInitiated
        } else {
            // Fallback on earlier versions
        }
    
        backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)
        
        mainScheduler = MainScheduler.sharedInstance
    }
    
}
