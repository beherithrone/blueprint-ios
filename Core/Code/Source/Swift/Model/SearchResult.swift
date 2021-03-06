//
//  SearchResult.swift
//  App-iOS
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import Foundation
import RxSwift

public struct SearchResult: CustomStringConvertible {
    public let title: String
    public let description: String
    public let URL: NSURL

    init(title: String, description: String, URL: NSURL) {
        self.title = title
        self.description = description
        self.URL = URL
    }

    // tedious parsing part
    static func parseJSON(json: [AnyObject]) throws -> [SearchResult] {
        let rootArrayTyped = json.map { $0 as? [AnyObject] }
            .filter { $0 != nil }
            .map { $0! }

        if rootArrayTyped.count != 3 {
            throw ParseError
        }

        let titleAndDescription = Array(Swift.zip(rootArrayTyped[0], rootArrayTyped[1]))
        let titleDescriptionAndUrl: [((AnyObject, AnyObject), AnyObject)] = Array(Swift.zip(titleAndDescription, rootArrayTyped[2]))

        let searchResults: [SearchResult] = try titleDescriptionAndUrl.map ( { result -> SearchResult in
            let (first, url) = result
            let (title, description) = first

            guard let titleString = title as? String,
                  let descriptionString = description as? String,
                  let urlString = url as? String,
                  let URL = NSURL(string: urlString) else {
                throw ParseError
            }

            return SearchResult(title: titleString, description: descriptionString, URL: URL)
        })

        return searchResults
    }
}
