//
//  API.swift
//  App-iOS
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public func apiError(error: String) -> NSError {
    return NSError(domain: "API", code: -1, userInfo: [NSLocalizedDescriptionKey: error])
}

public let ParseError = apiError("Error during parsing")

public protocol API {
    func getSearchResults(query: String) -> Observable<[SearchResult]>
    func articleContent(searchResult: SearchResult) -> Observable<Page>
}

func URLEscape(pathSegment: String) -> String {
   return pathSegment.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
}

public class DefaultAPI: API {

    public static let sharedAPI = DefaultAPI() // Singleton

    let $: Dependencies = Dependencies.sharedDependencies

    private init() {}

    // Example wikipedia response http://en.wikipedia.org/w/api.php?action=opensearch&search=Rx
    public func getSearchResults(query: String) -> Observable<[SearchResult]> {
        let escapedQuery = URLEscape(query)
        let urlContent = "http://en.wikipedia.org/w/api.php?action=opensearch&search=\(escapedQuery)"
        let url = NSURL(string: urlContent)!

        return $.URLSession
            .rx_JSON(url)
            .observeOn($.backgroundWorkScheduler)
            .map { json in
                guard let json = json as? [AnyObject] else {
                    throw exampleError("Parsing error")
                }

                return try SearchResult.parseJSON(json)
            }
            .observeOn($.mainScheduler)
    }

    // http://en.wikipedia.org/w/api.php?action=parse&page=rx&format=json
    public func articleContent(searchResult: SearchResult) -> Observable<Page> {
        let escapedPage = URLEscape(searchResult.title)
        guard let url = NSURL(string: "http://en.wikipedia.org/w/api.php?action=parse&page=\(escapedPage)&format=json") else {
            return failWith(apiError("Can't create url"))
        }

        return $.URLSession.rx_JSON(url)
            .map { jsonResult in
                guard let json = jsonResult as? NSDictionary else {
                    throw exampleError("Parsing error")
                }

                return try Page.parseJSON(json)
            }
            .observeOn($.mainScheduler)
    }
}
