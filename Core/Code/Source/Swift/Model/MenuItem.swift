//
//  MenuItem.swift
//  Core
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//
import Foundation
import RealmSwift

public class MenuItem : Object {
    
    dynamic var title : String = "";
    dynamic var icon : String  = "";
    dynamic var navigationId : String = "";
    
    public convenience required init(title : String, icon: String, navigationId: String) {
        self.init()
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
