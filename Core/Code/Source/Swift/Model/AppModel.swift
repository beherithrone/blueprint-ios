//
//  AppModel.swift
//  Core
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//
import Foundation

public class AppModel : NSObject {
    public var menuItems : [MenuItem] = [
        MenuItem(title: "Home", icon: "calendar", navigationId: "home"),
        MenuItem(title: "RxSearch", icon: "map", navigationId: "search"),
        MenuItem(title: "Login", icon: "news", navigationId: "home"),
        MenuItem(title: "Ad Example", icon: "photo", navigationId: "home"),
        MenuItem(title: "Camera Example", icon: "comments", navigationId: "home"),
        MenuItem(title: "Maps", icon: "tag", navigationId: "home"),
        MenuItem(title: "Swipe Cards", icon: "wishlist", navigationId: "home"),
        MenuItem(title: "Payments", icon: "calendar", navigationId: "home"),
        MenuItem(title: "Video", icon: "map", navigationId: "home")
    ];
    
    
}
