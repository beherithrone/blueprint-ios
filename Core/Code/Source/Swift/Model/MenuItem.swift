//
//  MenuItem.swift
//  Core
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//
import Foundation

public class MenuItem {
    
    private let title : String
    
    public init(title : String) {
        self.title = title
    }
    
    public func getTitle() -> String {
        return title
    }

}
