//
//  Page.swift
//  App-iOS
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import Foundation
import RxSwift

public struct Page {
    public let title: String
    public let text: String

    init(title: String, text: String) {
        self.title = title
        self.text = text
    }

    // tedious parsing part
    static func parseJSON(json: NSDictionary) throws -> Page {
        guard let title = json.valueForKey("parse")?.valueForKey("title") as? String,
              let text = json.valueForKey("parse")?.valueForKey("text")?.valueForKey("*") as? String else {
            throw apiError("Error parsing page content")
        }

        return Page(title: title, text: text)
    }
}
