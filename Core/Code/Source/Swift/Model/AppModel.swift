//
//  AppModel.swift
//  Core
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//
import Foundation
import RealmSwift

public class AppModel : Object {
    public var menuItems = List<MenuItem>();
}
