//
//  ImageService.swift
//  App-iOS
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import Core

protocol ImageService {
    func imageFromURL(URL: NSURL) -> Observable<UIImage>
}

class DefaultImageService: ImageService {
	
	static let sharedImageService = DefaultImageService() // Singleton
	
	let $: Dependencies = Dependencies.sharedDependencies
	
    // 1st level cache
    let imageCache = NSCache()
    
    // 2nd level cache
    let imageDataCache = NSCache()
    
    private init() {
        // cost is approx memory usage
        self.imageDataCache.totalCostLimit = 10 * MB
        
        self.imageCache.countLimit = 20
    }
    
    func decodeImage(imageData: NSData) -> Observable<UIImage> {
        return just(imageData)
            .observeOn($.backgroundWorkScheduler)
            .map { data in
                guard let image = UIImage(data: data) else {
                    // some error
                    throw apiError("Decoding image error")
                }
                return image
            }
            .observeOn($.mainScheduler)
    }
    
    func imageFromURL(URL: NSURL) -> Observable<UIImage> {
        return deferred {
            let maybeImage = self.imageCache.objectForKey(URL) as? UIImage
            
            let decodedImage: Observable<UIImage>
            
            // best case scenario, it's already decoded an in memory
            if let image = maybeImage {
                decodedImage = just(image)
            }
            else {
                let cachedData = self.imageDataCache.objectForKey(URL) as? NSData
                
                // does image data cache contain anything
                if let cachedData = cachedData {
                    decodedImage = self.decodeImage(cachedData)
                }
                else {
                    // fetch from network
                    decodedImage = self.$.URLSession.rx_data(NSURLRequest(URL: URL))
                        .doOn(next: { data in
                            self.imageDataCache.setObject(data, forKey: URL)
                        })
                        .flatMap(self.decodeImage)
                }
            }
            
            return decodedImage.doOn(next: { image in
                self.imageCache.setObject(image, forKey: URL)
            })
        }.observeOn($.mainScheduler)
    }
}
