//
//  AppModel.swift
//  Core
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//
import Foundation

public class AppModel : AnObject {
    public var menuItems = AnList();
    public var userFacebook : UserInfo?;
    public var userGoogle: UserInfo?;
    
    public func populate() -> Void {
        menuItems.append(MenuItem(title: "Home", icon: "calendar", navigationId: "home"));
        menuItems.append(MenuItem(title: "RxSearch", icon: "map", navigationId: "search"));
        menuItems.append(MenuItem(title: "Login", icon: "news", navigationId: "login"));
        menuItems.append(MenuItem(title: "Ad Example", icon: "photo", navigationId: "ads"));
        menuItems.append(MenuItem(title: "Camera Example", icon: "comments", navigationId: "camera"));
        menuItems.append(MenuItem(title: "Maps", icon: "tag", navigationId: "maps"));
        menuItems.append(MenuItem(title: "Swipe Cards", icon: "wishlist", navigationId: "swipe"));
        menuItems.append(MenuItem(title: "Payments", icon: "calendar", navigationId: "payments"));
        menuItems.append(MenuItem(title: "Video", icon: "map", navigationId: "home"));
        menuItems.append(MenuItem(title: "AWS Data", icon: "news", navigationId: "aws"));
        menuItems.append(MenuItem(title: "Publishing", icon: "photo", navigationId: "publishing"));
    }
}
