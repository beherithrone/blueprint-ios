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
    private let navigationId: String;
    
    public init(title : String, icon: String, navigationId: String) {
        self.title = title
        self.icon = icon
        self.navigationId = navigationId;
    }
    
    public func getTitle() -> String {
        return title
    }
    
    public func getIcon() -> String {
        return icon
    }
    
    public func getNavigationId() -> String {
        return navigationId
    }

}
