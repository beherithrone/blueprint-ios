//
//  Aliases.swift
//  Core
//
//  Created by Pavel Jacko on 09/11/2015.
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

public class List2<T> {
    
}

#if os(tvOS)
    public typealias AnObject = NSObject
    public typealias AnList = List2<MenuItem>
#else
    import RealmSwift
    public typealias AnObject = Object
    public typealias AnList = List<MenuItem>
#endif