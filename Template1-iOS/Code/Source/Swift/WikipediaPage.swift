//
//  WikipediaPage.swift
//  Template1-iOS
//
//  Copyright © 2015 Sky UK. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
import RxSwift
#endif

struct WikipediaPage {
    let title: String
    let text: String
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
    
    // tedious parsing part
    static func parseJSON(json: NSDictionary) throws -> WikipediaPage {
        guard let title = json.valueForKey("parse")?.valueForKey("title") as? String,
              let text = json.valueForKey("parse")?.valueForKey("text")?.valueForKey("*") as? String else {
            throw apiError("Error parsing page content")
        }
        
        return WikipediaPage(title: title, text: text)
    }
}