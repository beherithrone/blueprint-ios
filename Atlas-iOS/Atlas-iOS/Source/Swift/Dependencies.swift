//
//  Dependencies.swift
//  Atlas-iOS
//
//  Copyright © 2015 Sky UK. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
import RxSwift
#endif

class Dependencies {
    
    static let sharedDependencies = Dependencies() // Singleton
    
    let URLSession = NSURLSession.sharedSession()
    let backgroundWorkScheduler: ImmediateSchedulerType
    let mainScheduler: SerialDispatchQueueScheduler
    let wireframe: Wireframe
    
    private init() {
        wireframe = DefaultWireframe()
        
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        #if !RX_NO_MODULE
        operationQueue.qualityOfService = NSQualityOfService.UserInitiated
        #endif
        backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)
        
        mainScheduler = MainScheduler.sharedInstance
    }
    
}
