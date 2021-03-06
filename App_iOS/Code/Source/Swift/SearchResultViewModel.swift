//
//  SearchResultViewModel.swift
//  App-iOS
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Core_iOS

class SearchResultViewModel {
    let searchResult: SearchResult

    var title: Observable<String>
    var imageURLs: Observable<[NSURL]>

    let API = DefaultAPI.sharedAPI
    let $: Dependencies = Dependencies.sharedDependencies

    init(searchResult: SearchResult) {
        self.searchResult = searchResult

        self.title = never()
        self.imageURLs = never()

        let URLs = configureImageURLs()

        self.imageURLs = URLs.catchErrorJustReturn([])
        self.title = configureTitle(URLs).catchErrorJustReturn("Error during fetching")
    }

    // private methods

    func configureTitle(imageURLs: Observable<[NSURL]>) -> Observable<String> {
        let searchResult = self.searchResult

        let loadingValue: [NSURL]? = nil

        return imageURLs
            .map(Optional.init)
            .startWith(loadingValue)
            .map { URLs in
                if let URLs = URLs {
                    return "\(searchResult.title) (\(URLs.count)) pictures)"
                }
                else {
                    return "\(searchResult.title) loading ..."
                }
            }
    }

    func configureImageURLs() -> Observable<[NSURL]> {
        let searchResult = self.searchResult
        return API.articleContent(searchResult)
            .observeOn($.backgroundWorkScheduler)
            .map { page in
                do {
                    return try parseImageURLsfromHTMLSuitableForDisplay(page.text)
                } catch {
                    return []
                }
            }
            .observeOn($.mainScheduler)
            .shareReplay(1)
    }
}
