//
//  WikipediaSearchResult.swift
//  Atlas-iOS
//
//  Copyright © 2015 Sky UK. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
import RxSwift
#endif

struct WikipediaSearchResult: CustomStringConvertible {
    let title: String
    let description: String
    let URL: NSURL

    init(title: String, description: String, URL: NSURL) {
        self.title = title
        self.description = description
        self.URL = URL
    }

    // tedious parsing part
    static func parseJSON(json: [AnyObject]) throws -> [WikipediaSearchResult] {
        let rootArrayTyped = json.map { $0 as? [AnyObject] }
            .filter { $0 != nil }
            .map { $0! }

        if rootArrayTyped.count != 3 {
            throw WikipediaParseError
        }

        let titleAndDescription = Array(Swift.zip(rootArrayTyped[0], rootArrayTyped[1]))
        let titleDescriptionAndUrl: [((AnyObject, AnyObject), AnyObject)] = Array(Swift.zip(titleAndDescription, rootArrayTyped[2]))
        
        let searchResults: [WikipediaSearchResult] = try titleDescriptionAndUrl.map ( { result -> WikipediaSearchResult in
            let (first, url) = result
            let (title, description) = first

            guard let titleString = title as? String,
                  let descriptionString = description as? String,
                  let urlString = url as? String,
                  let URL = NSURL(string: urlString) else {
                throw WikipediaParseError
            }

            return WikipediaSearchResult(title: titleString, description: descriptionString, URL: URL)
        })

        return searchResults
    }
}
