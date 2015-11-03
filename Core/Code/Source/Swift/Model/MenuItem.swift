//
//  MenuItem.swift
//  Core
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//
import Foundation

public class MenuItem {
    
    private let title : String
    private let icon: String;
    
    public init(title : String, icon: String) {
        self.title = title
        self.icon = icon
    }
    
    public func getTitle() -> String {
        return title
    }
    
    public func getIcon() -> String {
        return icon
    }

}
